import json
import unittest

from trello_todo import commands
from trello_todo.cli import normalise_argv
from trello_todo.config import Settings
from trello_todo.errors import TrelloTodoError
from trello_todo.lookup import find_card
from trello_todo.models import Card, TrelloList

CARDS = [
    Card(id="a" * 24, name="Commit dotfiles", url="https://trello.com/c/a"),
    Card(id="b" * 24, name="Commit notes", url="https://trello.com/c/b"),
]


class FakeClient:
    def get_lists_with_cards(self):
        return [
            TrelloList(id="l1", name="Later", cards=tuple(CARDS)),
            TrelloList(id="l2", name="Today"),
        ]


class FindCardTests(unittest.TestCase):
    def test_exact_id_wins_over_ambiguous_title(self):
        self.assertEqual(find_card(CARDS, "b" * 24), CARDS[1])

    def test_title_substring_still_works(self):
        self.assertEqual(find_card(CARDS, "dotfiles"), CARDS[0])

    def test_ambiguous_title_still_errors(self):
        with self.assertRaises(TrelloTodoError):
            find_card(CARDS, "commit")


class ShowJsonTests(unittest.TestCase):
    def test_includes_empty_lists_ids_urls_and_settings(self):
        settings = Settings(board_id="x", default_list="Later", done_list="Done")
        data = json.loads(commands.show_json(FakeClient(), settings))
        self.assertEqual(data["default_list"], "Later")
        self.assertEqual(data["done_list"], "Done")
        self.assertEqual([item["name"] for item in data["lists"]], ["Later", "Today"])
        self.assertEqual(data["lists"][0]["cards"][0], {"id": "a" * 24, "name": "Commit dotfiles", "url": "https://trello.com/c/a"})
        self.assertEqual(data["lists"][1]["cards"], [])


class NormaliseArgvTests(unittest.TestCase):
    def test_json_flag_is_not_treated_as_a_title(self):
        self.assertEqual(normalise_argv(["--show", "--json"]), ["--show", "--json"])
        self.assertEqual(normalise_argv(["--json"]), ["--json"])


if __name__ == "__main__":
    unittest.main()
