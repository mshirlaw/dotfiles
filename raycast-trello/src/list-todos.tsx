import { Icon, List } from "@raycast/api";
import { listsToShow } from "./board";
import { CardItem } from "./card-item";
import { useBoard } from "./use-board";

export default function Command() {
  const { data: board, isLoading, revalidate } = useBoard();

  return (
    <List isLoading={isLoading} searchBarPlaceholder="Search todos">
      {board &&
        listsToShow(board).map((list) => (
          <List.Section key={list.id} title={list.name} subtitle={String(list.cards.length)}>
            {list.cards.map((card) => (
              <CardItem key={card.id} board={board} list={list} card={card} onChange={revalidate} />
            ))}
          </List.Section>
        ))}
      <List.EmptyView title="No open todos" icon={Icon.CheckCircle} />
    </List>
  );
}
