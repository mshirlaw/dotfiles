"""Thin wrapper around the Trello REST API."""

from __future__ import annotations

import json
import ssl
from pathlib import Path
from typing import Any, Optional
from urllib.error import HTTPError, URLError
from urllib.parse import urlencode
from urllib.request import Request, urlopen

from .errors import TrelloTodoError
from .models import Card, TrelloList

API_URL = "https://api.trello.com/1"
TIMEOUT_SECONDS = 15
SYSTEM_CA_BUNDLE = Path("/etc/ssl/cert.pem")


def build_ssl_context() -> ssl.SSLContext:
    """Use the default trust store, or macOS's bundle when Python ships without one."""
    context = ssl.create_default_context()
    if context.cert_store_stats()["x509_ca"] == 0 and SYSTEM_CA_BUNDLE.is_file():
        context = ssl.create_default_context(cafile=str(SYSTEM_CA_BUNDLE))
    return context


class TrelloClient:
    def __init__(self, api_key: str, token: str, board_id: str) -> None:
        self._auth = {"key": api_key, "token": token}
        self._board_id = board_id
        self._ssl_context = build_ssl_context()

    def _request(
        self, method: str, path: str, params: Optional[dict[str, str]] = None
    ) -> Any:
        query = urlencode({**(params or {}), **self._auth})
        request = Request(f"{API_URL}/{path}?{query}", method=method)
        try:
            with urlopen(
                request, timeout=TIMEOUT_SECONDS, context=self._ssl_context
            ) as response:
                body = response.read()
        except HTTPError as error:
            # The URL contains the token, so never include it in the message.
            raise TrelloTodoError(
                f"Trello returned {error.code} for {method} {path}"
            ) from None
        except URLError as error:
            raise TrelloTodoError(f"Could not reach Trello: {error.reason}") from None
        return json.loads(body) if body else None

    def get_lists(self) -> list[TrelloList]:
        data = self._request("GET", f"boards/{self._board_id}/lists", {"fields": "name"})
        return [TrelloList(id=item["id"], name=item["name"]) for item in data]

    def get_lists_with_cards(self) -> list[TrelloList]:
        data = self._request(
            "GET",
            f"boards/{self._board_id}/lists",
            {"fields": "name", "cards": "open", "card_fields": "name,shortUrl"},
        )
        return [
            TrelloList(
                id=item["id"],
                name=item["name"],
                cards=tuple(
                    Card(id=c["id"], name=c["name"], url=c.get("shortUrl", ""))
                    for c in item["cards"]
                ),
            )
            for item in data
        ]

    def get_open_cards(self) -> list[Card]:
        data = self._request(
            "GET", f"boards/{self._board_id}/cards/open", {"fields": "name"}
        )
        return [Card(id=item["id"], name=item["name"]) for item in data]

    def create_card(self, list_id: str, title: str) -> Card:
        data = self._request("POST", "cards", {"idList": list_id, "name": title})
        return Card(id=data["id"], name=data["name"], url=data["shortUrl"])

    def move_card(self, card_id: str, list_id: str) -> None:
        self._request("PUT", f"cards/{card_id}", {"idList": list_id})

    def rename_card(self, card_id: str, title: str) -> None:
        self._request("PUT", f"cards/{card_id}", {"name": title})

    def delete_card(self, card_id: str) -> None:
        self._request("DELETE", f"cards/{card_id}")
