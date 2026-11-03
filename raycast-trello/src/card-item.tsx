import { Color, Icon, List } from "@raycast/api";
import { CardActions } from "./card-actions";
import { isDoneList } from "./board";
import { Board, Card, TrelloList } from "./trello";

const LIST_COLOURS: Record<string, Color> = {
  later: Color.Blue,
  "this week": Color.Purple,
  today: Color.Orange,
  "in progress": Color.Green,
  "waiting on": Color.Magenta,
};

function cardIcon(board: Board, list: TrelloList): List.Item.Props["icon"] {
  return {
    source: isDoneList(board, list) ? Icon.CheckCircle : Icon.Circle,
    tintColor: LIST_COLOURS[list.name.toLowerCase()] ?? Color.SecondaryText,
  };
}

export function CardItem({
  board,
  list,
  card,
  onChange,
}: {
  board: Board;
  list: TrelloList;
  card: Card;
  onChange: () => void;
}) {
  return (
    <List.Item
      title={card.name}
      keywords={[list.name]}
      icon={cardIcon(board, list)}
      actions={<CardActions board={board} list={list} card={card} onChange={onChange} />}
    />
  );
}
