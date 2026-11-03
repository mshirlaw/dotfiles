import unittest

from trello_todo import commands
from trello_todo.cli import normalise_argv
from trello_todo.models import Card, TrelloList


class RecordingClient:
    def __init__(self):
        self.created = None

    def get_lists(self):
        return [TrelloList(id="l1", name="Later")]

    def create_card(self, list_id, title, description=""):
        self.created = (list_id, title, description)
        return Card(id="c1", name=title, url="https://trello.com/c/c1")


class AddCardTests(unittest.TestCase):
    def test_description_is_passed_to_the_client(self):
        client = RecordingClient()
        commands.add_card(client, "Title", "Later", "Some detail")
        self.assertEqual(client.created, ("l1", "Title", "Some detail"))

    def test_description_is_optional(self):
        client = RecordingClient()
        commands.add_card(client, "Title", "Later")
        self.assertEqual(client.created, ("l1", "Title", ""))


class NormaliseDescriptionTests(unittest.TestCase):
    def test_description_option_can_precede_the_title(self):
        self.assertEqual(
            normalise_argv(["-d", "detail", "Title"]),
            ["--add", "Title", "-d", "detail"],
        )

    def test_equals_form_keeps_text_starting_with_a_dash(self):
        self.assertEqual(
            normalise_argv(["Title", "--description=-not a flag"]),
            ["--add", "Title", "--description=-not a flag"],
        )


if __name__ == "__main__":
    unittest.main()
