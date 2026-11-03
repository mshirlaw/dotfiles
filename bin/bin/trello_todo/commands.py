"""One function per CLI command. Each returns the text to print."""

from __future__ import annotations

import json
from typing import Optional

from .client import TrelloClient
from .config import Settings
from .lookup import find_card, find_list
from .render import format_board


def add_card(client: TrelloClient, title: str, list_name: str, description: str = "") -> str:
    target = find_list(client.get_lists(), list_name)
    card = client.create_card(target.id, title, description)
    return f"Created in {target.name}: {card.name}\n{card.url}"


def list_names(client: TrelloClient) -> str:
    return "\n".join(item.name for item in client.get_lists())


def show_board(
    client: TrelloClient,
    width: int,
    colour: bool,
    list_name: Optional[str] = None,
) -> str:
    lists = client.get_lists_with_cards()
    if list_name:
        return format_board([find_list(lists, list_name)], width, colour)
    return format_board([item for item in lists if item.cards], width, colour)


def show_json(client: TrelloClient, settings: Settings) -> str:
    """Every list, including empty ones, with card ids and urls, for other programs."""
    lists = client.get_lists_with_cards()
    return json.dumps(
        {
            "default_list": settings.default_list,
            "done_list": settings.done_list,
            "lists": [
                {
                    "id": item.id,
                    "name": item.name,
                    "cards": [
                        {"id": card.id, "name": card.name, "url": card.url}
                        for card in item.cards
                    ],
                }
                for item in lists
            ],
        },
        indent=2,
    )


def move_card(client: TrelloClient, query: str, list_name: str) -> str:
    card = find_card(client.get_open_cards(), query)
    target = find_list(client.get_lists(), list_name)
    client.move_card(card.id, target.id)
    return f"Moved to {target.name}: {card.name}"


def finish_card(client: TrelloClient, query: str, done_list: str) -> str:
    return move_card(client, query, done_list)


def rename_card(client: TrelloClient, query: str, title: str) -> str:
    card = find_card(client.get_open_cards(), query)
    client.rename_card(card.id, title)
    return f"Renamed: {card.name} -> {title}"


def delete_card(client: TrelloClient, query: str) -> str:
    card = find_card(client.get_open_cards(), query)
    client.delete_card(card.id)
    return f"Deleted: {card.name}"
