"""Find lists and cards by name."""

from __future__ import annotations

from typing import Sequence

from .errors import TrelloTodoError
from .models import Card, TrelloList


def find_list(lists: Sequence[TrelloList], name: str) -> TrelloList:
    """Return the list whose name matches, ignoring case."""
    for trello_list in lists:
        if trello_list.name.lower() == name.lower():
            return trello_list
    available = ", ".join(trello_list.name for trello_list in lists)
    raise TrelloTodoError(f"No list named '{name}'. Available: {available}")


def find_card(cards: Sequence[Card], query: str) -> Card:
    """Return the card with this exact id, else the single card whose title contains the query."""
    for card in cards:
        if card.id == query:
            return card
    matches = [card for card in cards if query.lower() in card.name.lower()]
    if not matches:
        raise TrelloTodoError(f"No open card matches '{query}'")
    if len(matches) > 1:
        titles = "\n".join(f"  {card.name}" for card in matches)
        raise TrelloTodoError(
            f"'{query}' matches {len(matches)} cards, be more specific:\n{titles}"
        )
    return matches[0]
