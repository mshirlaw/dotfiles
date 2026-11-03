"""Board settings and credential loading."""

from __future__ import annotations

import configparser
import os
import re
from dataclasses import dataclass
from pathlib import Path
from typing import Mapping, Optional

from .errors import TrelloTodoError

CONFIG_DIR = Path.home() / ".config" / "trello"
CREDENTIALS_FILE = CONFIG_DIR / "credentials"
SETTINGS_FILE = CONFIG_DIR / "config.ini"
SETTINGS_SECTION = "trello"
FALLBACK_DEFAULT_LIST = "Later"
FALLBACK_DONE_LIST = "Done"

_EXPORT_LINE = re.compile(r"""^\s*(?:export\s+)?(\w+)=(.*?)\s*$""")


def parse_credentials_file(text: str) -> dict[str, str]:
    """Parse shell style `export KEY=value` lines into a dict."""
    values = {}
    for line in text.splitlines():
        match = _EXPORT_LINE.match(line)
        if match is None or line.lstrip().startswith("#"):
            continue
        key, value = match.groups()
        values[key] = value.strip("\"'")
    return values


def load_credentials(
    environ: Optional[Mapping[str, str]] = None,
    credentials_file: Path = CREDENTIALS_FILE,
) -> tuple[str, str]:
    """Return (api_key, token) from the environment, falling back to the credentials file."""
    environ = os.environ if environ is None else environ
    values = {
        "TRELLO_API_KEY": environ.get("TRELLO_API_KEY", ""),
        "TRELLO_TOKEN": environ.get("TRELLO_TOKEN", ""),
    }
    if not all(values.values()) and credentials_file.is_file():
        from_file = parse_credentials_file(credentials_file.read_text())
        values = {key: values[key] or from_file.get(key, "") for key in values}

    for key, value in values.items():
        if not value:
            raise TrelloTodoError(f"{key} not set")
    return values["TRELLO_API_KEY"], values["TRELLO_TOKEN"]


@dataclass(frozen=True)
class Settings:
    board_id: str
    default_list: str
    done_list: str


def parse_settings(text: str) -> Settings:
    """Parse the INI settings. Only board_id is required."""
    parser = configparser.ConfigParser()
    try:
        parser.read_string(text)
    except configparser.Error as error:
        raise TrelloTodoError(f"Could not read {SETTINGS_FILE}: {error.message.splitlines()[0]}") from None
    section = parser[SETTINGS_SECTION] if parser.has_section(SETTINGS_SECTION) else {}
    board_id = section.get("board_id", "").strip()
    if not board_id:
        raise TrelloTodoError(f"board_id not set in [{SETTINGS_SECTION}] of {SETTINGS_FILE}")
    return Settings(
        board_id=board_id,
        default_list=section.get("default_list", FALLBACK_DEFAULT_LIST).strip(),
        done_list=section.get("done_list", FALLBACK_DONE_LIST).strip(),
    )


def load_settings(settings_file: Path = SETTINGS_FILE) -> Settings:
    """Read the settings file, explaining how to create it when it is missing."""
    if not settings_file.is_file():
        raise TrelloTodoError(
            f"No settings file at {settings_file}. Create it with:\n"
            f"  [{SETTINGS_SECTION}]\n"
            "  board_id = <the id in your board's URL, trello.com/b/<id>/...>\n"
            "  default_list = Later   # optional\n"
            "  done_list = Done       # optional"
        )
    return parse_settings(settings_file.read_text())
