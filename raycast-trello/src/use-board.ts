import { useCachedPromise } from "@raycast/utils";
import { fetchBoard } from "./trello";

export function useBoard() {
  return useCachedPromise(fetchBoard, [], {
    failureToastOptions: { title: "Could not load the board" },
  });
}
