"""Format the board for the terminal."""

from __future__ import annotations

import re
from typing import Sequence

from .models import TrelloList

BOLD = "\033[1m"
DIM = "\033[2m"
RESET = "\033[0m"
DEFAULT_COLOUR = 90
LIST_COLOURS = {
    "later": 34,
    "this week": 36,
    "today": 33,
    "in progress": 32,
    "waiting on": 35,
}
BULLET_INDENT = "  • "
_URL = re.compile(r"https?://([^/\s]+)\S*")


def shorten_urls(text: str) -> str:
    """Replace each URL with its host so long links don't fill the line."""
    return _URL.sub(r"\1/…", text)


def truncate(text: str, width: int) -> str:
    """Cut text to the width, ending with an ellipsis when it was shortened."""
    if len(text) <= width:
        return text
    return text[: max(width - 1, 0)] + "…"


def list_colour(name: str) -> int:
    return LIST_COLOURS.get(name.lower(), DEFAULT_COLOUR)


def paint(text: str, enabled: bool, *codes: str) -> str:
    """Wrap text in ANSI codes, or return it unchanged when colour is off."""
    if not enabled:
        return text
    return "".join(codes) + text + RESET


def format_header(trello_list: TrelloList, colour: bool) -> str:
    """Format the list name followed by its card count, or `(empty)`."""
    if not trello_list.cards:
        return paint(f"{trello_list.name} (empty)", colour, DIM)
    tint = f"\033[{list_colour(trello_list.name)}m"
    name = paint(trello_list.name, colour, BOLD, tint)
    count = paint(f"({len(trello_list.cards)})", colour, DIM)
    return f"{name} {count}"


def format_card(name: str, width: int, colour: bool) -> str:
    """Format one card as a bullet, shortened to fit the terminal width."""
    room = width - len(BULLET_INDENT)
    return f"  {paint('•', colour, DIM)} {truncate(shorten_urls(name), room)}"


def format_list(trello_list: TrelloList, width: int, colour: bool) -> str:
    """Format one list: a header line followed by a bullet per card."""
    cards = [format_card(card.name, width, colour) for card in trello_list.cards]
    return "\n".join([format_header(trello_list, colour), *cards])


def format_board(lists: Sequence[TrelloList], width: int, colour: bool) -> str:
    """Format several lists separated by blank lines."""
    return "\n\n".join(format_list(item, width, colour) for item in lists)
