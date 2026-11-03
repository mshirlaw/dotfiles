import { Board, TrelloList } from "./trello";

export const IN_PROGRESS_LIST = "In Progress";

const LIST_ORDER = [IN_PROGRESS_LIST, "Today", "This Week", "Later"].map((name) => name.toLowerCase());

function rank(list: TrelloList): number {
  const index = LIST_ORDER.indexOf(list.name.toLowerCase());
  return index === -1 ? LIST_ORDER.length : index;
}

/**
 * Lists that have cards, in display order. Unranked lists keep the board's order because the sort is stable.
 */
export function listsToShow(board: Board): TrelloList[] {
  return board.lists.filter((list) => list.cards.length > 0).sort((a, b) => rank(a) - rank(b));
}

export function isDoneList(board: Board, list: TrelloList): boolean {
  return list.name === board.done_list;
}

export function isInProgressList(list: TrelloList): boolean {
  return list.name === IN_PROGRESS_LIST;
}

export function otherLists(board: Board, list: TrelloList): TrelloList[] {
  return board.lists.filter((candidate) => candidate.id !== list.id);
}
