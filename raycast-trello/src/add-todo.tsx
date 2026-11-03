import { Action, ActionPanel, Form, popToRoot, useNavigation } from "@raycast/api";
import { FormValidation, useForm } from "@raycast/utils";
import { useEffect, useState } from "react";
import { runWithToast } from "./toast";
import { Board, addCard } from "./trello";
import { useBoard } from "./use-board";

/**
 * Controlled so the default list can be selected once the board has loaded.
 */
function useSelectedList(board: Board | undefined) {
  const [list, setList] = useState("");

  useEffect(() => {
    if (board && !list) {
      setList(board.default_list);
    }
  }, [board]);

  return [list, setList] as const;
}

/**
 * `onAdded` is set when pushed from the list, so we go back instead of closing Raycast.
 */
export function AddTodoForm({ onAdded }: { onAdded?: () => void }) {
  const { data: board, isLoading } = useBoard();
  const { pop } = useNavigation();
  const [list, setList] = useSelectedList(board);

  async function leave() {
    if (!onAdded) {
      await popToRoot();
      return;
    }
    onAdded();
    pop();
  }

  const { handleSubmit, itemProps } = useForm<{ title: string; description: string }>({
    async onSubmit({ title, description }) {
      const messages = { progress: "Adding todo", success: `Added to ${list}`, failure: "Could not add todo" };
      if (await runWithToast(messages, () => addCard(title.trim(), list, description.trim()))) {
        await leave();
      }
    },
    validation: { title: FormValidation.Required },
  });

  return (
    <Form
      isLoading={isLoading}
      actions={
        <ActionPanel>
          <Action.SubmitForm title="Add Todo" onSubmit={handleSubmit} />
        </ActionPanel>
      }
    >
      <Form.TextField title="Title" placeholder="What needs doing?" autoFocus {...itemProps.title} />
      <Form.TextArea
        title="Description"
        placeholder="Add a more detailed description…"
        enableMarkdown
        {...itemProps.description}
      />
      <Form.Dropdown id="list" title="List" value={list} onChange={setList} isLoading={isLoading}>
        {(board?.lists ?? []).map((item) => (
          <Form.Dropdown.Item key={item.id} value={item.name} title={item.name} />
        ))}
      </Form.Dropdown>
    </Form>
  );
}

export default function Command() {
  return <AddTodoForm />;
}
