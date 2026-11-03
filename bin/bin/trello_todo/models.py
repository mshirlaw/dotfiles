"""Plain data types returned by the Trello client."""

from __future__ import annotations

from dataclasses import dataclass, field


@dataclass(frozen=True)
class Card:
    id: str
    name: str
    url: str = ""


@dataclass(frozen=True)
class TrelloList:
    id: str
    name: str
    cards: tuple[Card, ...] = field(default_factory=tuple)
