import { Action, ActionPanel, Form, useNavigation } from "@raycast/api";
import { FormValidation, useForm } from "@raycast/utils";
import { runWithToast } from "./toast";
import { Card, renameCard } from "./trello";

export function RenameForm({ card, onRenamed }: { card: Card; onRenamed: () => void }) {
  const { pop } = useNavigation();

  const { handleSubmit, itemProps } = useForm<{ title: string }>({
    async onSubmit({ title }) {
      const messages = { progress: "Renaming", success: "Renamed", failure: "Could not rename" };
      if (await runWithToast(messages, () => renameCard(card.id, title.trim()))) {
        onRenamed();
        pop();
      }
    },
    initialValues: { title: card.name },
    validation: { title: FormValidation.Required },
  });

  return (
    <Form
      actions={
        <ActionPanel>
          <Action.SubmitForm title="Rename" onSubmit={handleSubmit} />
        </ActionPanel>
      }
    >
      <Form.TextField title="Title" autoFocus {...itemProps.title} />
    </Form>
  );
}
