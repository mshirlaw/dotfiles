# Trello Todo (Raycast extension)

A private Raycast extension for the board managed by the `trello-todo` CLI (`bin/bin/trello-todo`). All Trello access goes through the CLI, so the credentials in `~/.config/trello/credentials` and the board settings in `~/.config/trello/config.ini` are the only configuration.

Commands:

- **List Todos**: searchable list grouped by Trello list, with In Progress, Today, This Week and Later first. Open, Mark Done (⌘↵), Start (⌘I, moves to In Progress), Move to… (⌘M), Rename (⌘E), Copy URL (⇧⌘C), Add (⌘N), Refresh (⌘R), Delete (⌃X).
- **Add Todo**: form with a title, a markdown description and a list dropdown that defaults to `default_list`.

The extension needs `trello-todo --show --json` and card-id arguments, so keep the CLI and the extension in step. Set the "trello-todo Path" preference if the CLI is not at `~/bin/trello-todo` (Raycast does not load your shell profile, so `PATH` is not searched).

## Install

This directory is not a stow package. Import it in place:

    cd raycast-trello
    npm install
    npm run dev    # registers the extension with Raycast, then Ctrl+C

The extension stays in Raycast after `npm run dev` exits. Run it again to iterate on changes.
