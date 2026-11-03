import { Action, ActionPanel, Alert, Icon, Keyboard, confirmAlert } from "@raycast/api";
import { AddTodoForm } from "./add-todo";
import { IN_PROGRESS_LIST, isDoneList, isInProgressList, otherLists } from "./board";
import { RenameForm } from "./rename-form";
import { ToastMessages, runWithToast } from "./toast";
import { Board, Card, TrelloList, deleteCard, finishCard, moveCard } from "./trello";

interface CardActionsProps {
  board: Board;
  list: TrelloList;
  card: Card;
  onChange: () => void;
}

function confirmDelete(card: Card): Promise<boolean> {
  return confirmAlert({
    title: "Delete this card?",
    message: card.name,
    primaryAction: { title: "Delete", style: Alert.ActionStyle.Destructive },
  });
}

function MoveToMenu({ board, list, onMove }: { board: Board; list: TrelloList; onMove: (target: TrelloList) => void }) {
  return (
    <ActionPanel.Submenu title="Move to…" icon={Icon.ArrowRight} filtering shortcut={{ modifiers: ["cmd"], key: "m" }}>
      {otherLists(board, list).map((target) => (
        <Action key={target.id} title={target.name} onAction={() => onMove(target)} />
      ))}
    </ActionPanel.Submenu>
  );
}

export function CardActions({ board, list, card, onChange }: CardActionsProps) {
  async function changeCard(messages: ToastMessages, work: () => Promise<unknown>) {
    if (await runWithToast(messages, work)) {
      onChange();
    }
  }

  const markDone = () =>
    changeCard({ progress: "Moving to Done", success: "Moved to Done", failure: "Could not move card" }, () =>
      finishCard(card.id),
    );

  const moveToName = (name: string) =>
    changeCard({ progress: `Moving to ${name}`, success: `Moved to ${name}`, failure: "Could not move card" }, () =>
      moveCard(card.id, name),
    );

  const moveTo = (target: TrelloList) => moveToName(target.name);

  const startWork = () => moveToName(IN_PROGRESS_LIST);

  async function remove() {
    if (await confirmDelete(card)) {
      await changeCard({ progress: "Deleting", success: "Deleted", failure: "Could not delete card" }, () =>
        deleteCard(card.id),
      );
    }
  }

  return (
    <ActionPanel>
      <ActionPanel.Section>
        <Action.OpenInBrowser title="Open in Trello" url={card.url} />
        {/* The second action gets cmd+enter automatically. */}
        {!isDoneList(board, list) && <Action title="Mark Done" icon={Icon.CheckCircle} onAction={markDone} />}
        {!isInProgressList(list) && (
          <Action title="Start" icon={Icon.Play} shortcut={{ modifiers: ["cmd"], key: "i" }} onAction={startWork} />
        )}
        <MoveToMenu board={board} list={list} onMove={moveTo} />
        <Action.Push
          title="Rename"
          icon={Icon.Pencil}
          shortcut={Keyboard.Shortcut.Common.Edit}
          target={<RenameForm card={card} onRenamed={onChange} />}
        />
      </ActionPanel.Section>
      <ActionPanel.Section>
        <Action.CopyToClipboard title="Copy Card URL" content={card.url} shortcut={Keyboard.Shortcut.Common.Copy} />
        <Action.Push
          title="Add Todo"
          icon={Icon.Plus}
          shortcut={Keyboard.Shortcut.Common.New}
          target={<AddTodoForm onAdded={onChange} />}
        />
        <Action
          title="Refresh"
          icon={Icon.ArrowClockwise}
          shortcut={Keyboard.Shortcut.Common.Refresh}
          onAction={onChange}
        />
      </ActionPanel.Section>
      <ActionPanel.Section>
        <Action
          title="Delete Card"
          icon={Icon.Trash}
          style={Action.Style.Destructive}
          shortcut={Keyboard.Shortcut.Common.Remove}
          onAction={remove}
        />
      </ActionPanel.Section>
    </ActionPanel>
  );
}
