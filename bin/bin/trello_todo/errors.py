"""Errors raised by trello-todo that should be shown to the user as-is."""

from __future__ import annotations


class TrelloTodoError(Exception):
    """A problem the user can act on; the CLI prints it without a traceback."""
