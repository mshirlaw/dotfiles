"""Argument parsing and dispatch."""

from __future__ import annotations

import argparse
import os
import shutil
import sys
from typing import Optional, Sequence

from . import commands
from .client import TrelloClient
from .config import Settings, load_credentials, load_settings
from .errors import TrelloTodoError

COMMANDS = (
    ('"<title>" [list]', "create a card (default list from your settings file)"),
    ("<title words> -l <list>", "same, without quoting the title"),
    ("<title> -d <text>", "add a description to the new card"),
    ('--add "<title>" [list]', "same as the first form"),
    ("--lists", "print list names"),
    ("--show [list]", "print open cards, optionally for one list"),
    ("--show --json", "print every list and card, with ids, as JSON"),
    ('--move "<card>" <list>', "move a card to a list"),
    ('--done "<card>"', "move a card to Done"),
    ('--rename "<card>" "<new title>"', "rename a card"),
    ('--delete "<card>"', "permanently delete a card"),
)


def format_commands(commands: Sequence[tuple[str, str]]) -> str:
    """Lay the commands out as an aligned two column table."""
    gutter = max(len(usage) for usage, _ in commands) + 2
    return "\n".join(f"  {usage:<{gutter}}{text}" for usage, text in commands)


DESCRIPTION = (
    "Manage cards on your Trello board.\n\n"
    f"Commands:\n{format_commands(COMMANDS)}"
)
EPILOG = """\
<card> is a card id, or a case-insensitive substring of the card title that
matches exactly one open card.

Trello's personal Inbox panel is not writable with a classic key/token (401).

Credentials: TRELLO_API_KEY and TRELLO_TOKEN from the environment, or from
~/.config/trello/credentials (shell `export` lines, kept out of git) if unset.

Settings: board_id (required), default_list and done_list (optional) in the
[trello] section of ~/.config/trello/config.ini.
"""
ACTIONS = ("add", "lists", "show", "move", "done", "rename", "delete")


LIST_FLAGS = ("-l", "--list")
DESCRIPTION_FLAGS = ("-d", "--description")
VALUE_FLAGS = LIST_FLAGS + DESCRIPTION_FLAGS
VALUE_FLAG_PREFIXES = ("--list=", "--description=")
COMMAND_FLAGS = frozenset({f"--{action}" for action in ACTIONS} | {"-h", "--help", "--json"})


def split_value_options(argv: Sequence[str]) -> tuple[list[str], list[str]]:
    """Separate the `-l <list>` and `-d <text>` options from the other arguments."""
    rest: list[str] = []
    option: list[str] = []
    tokens = iter(argv)
    for token in tokens:
        if token in VALUE_FLAGS:
            option.append(token)
            value = next(tokens, None)
            if value is not None:
                option.append(value)
        elif token.startswith(VALUE_FLAG_PREFIXES):
            option.append(token)
        else:
            rest.append(token)
    return rest, option


def normalise_argv(argv: Sequence[str]) -> list[str]:
    """Treat arguments with no command flag as `--add <title words>`.

    The value options are moved to the end so they can follow or precede the title.
    """
    rest, option = split_value_options(argv)
    if rest and not COMMAND_FLAGS.intersection(rest):
        rest = ["--add", *rest]
    return [*rest, *option]


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="trello-todo",
        description=DESCRIPTION,
        epilog=EPILOG,
        formatter_class=argparse.RawDescriptionHelpFormatter,
        usage="trello-todo <command> [args]",
    )
    # The commands are documented in the description table, so hide them here.
    hidden = {"help": argparse.SUPPRESS}
    group = parser.add_mutually_exclusive_group()
    group.add_argument("--add", nargs="+", metavar="ARG", **hidden)
    group.add_argument("--lists", action="store_true", **hidden)
    group.add_argument("--show", nargs="?", const="", metavar="LIST", **hidden)
    group.add_argument("--move", nargs=2, metavar="ARG", **hidden)
    group.add_argument("--done", metavar="CARD", **hidden)
    group.add_argument("--rename", nargs=2, metavar="ARG", **hidden)
    group.add_argument("--delete", metavar="CARD", **hidden)
    parser.add_argument("-l", "--list", dest="list_name", metavar="LIST", **hidden)
    parser.add_argument("-d", "--description", metavar="TEXT", **hidden)
    parser.add_argument("--json", action="store_true", **hidden)
    return parser


def resolve_add_arguments(
    parser: argparse.ArgumentParser, args: argparse.Namespace, default_list: str
) -> tuple[str, str]:
    """Work out the (title, list) to add from the words given."""
    words = args.add
    if args.list_name:
        return " ".join(words), args.list_name
    if len(words) == 1:
        return words[0], default_list
    if len(words) == 2:
        return words[0], words[1]
    joined = " ".join(words)
    parser.error(
        f"--add got {len(words)} separate words. Quote the title or pick a list with -l:\n"
        f'  trello-todo --add "{joined}"\n'
        f"  trello-todo --add {joined} -l <list>"
    )


def selected_action(args: argparse.Namespace) -> Optional[str]:
    """Return the name of the one action flag that was given, if any."""
    for action in ACTIONS:
        value = getattr(args, action)
        if value not in (None, False):
            return action
    return None


def run(
    action: str,
    args: argparse.Namespace,
    client: TrelloClient,
    settings: Settings,
    add_request: tuple[str, str],
) -> str:
    if action == "add":
        return commands.add_card(client, *add_request, args.description or "")
    if action == "lists":
        return commands.list_names(client)
    if action == "show" and args.json:
        return commands.show_json(client, settings)
    if action == "show":
        width = shutil.get_terminal_size((100, 24)).columns
        colour = sys.stdout.isatty() and "NO_COLOR" not in os.environ
        return commands.show_board(client, width, colour, args.show or None)
    if action == "move":
        return commands.move_card(client, *args.move)
    if action == "done":
        return commands.finish_card(client, args.done, settings.done_list)
    if action == "rename":
        return commands.rename_card(client, *args.rename)
    return commands.delete_card(client, args.delete)


def main(argv: Optional[Sequence[str]] = None) -> int:
    parser = build_parser()
    args = parser.parse_args(normalise_argv(sys.argv[1:] if argv is None else argv))
    action = selected_action(args)
    if action is None:
        parser.error("no command given, see --help")
    if args.json and action != "show":
        parser.error("--json only applies to --show")
    if args.list_name and action != "add":
        parser.error("-l only applies when adding a card")
    if args.description and action != "add":
        parser.error("-d only applies when adding a card")
    try:
        settings = load_settings()
        add_request = (
            resolve_add_arguments(parser, args, settings.default_list)
            if args.add
            else ("", "")
        )
        client = TrelloClient(*load_credentials(), board_id=settings.board_id)
        output = run(action, args, client, settings, add_request)
    except TrelloTodoError as error:
        print(error, file=sys.stderr)
        return 1
    if output:
        print(output)
    return 0
