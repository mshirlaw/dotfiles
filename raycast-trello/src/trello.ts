import { execFile } from "child_process";
import { homedir } from "os";
import { promisify } from "util";
import { getPreferenceValues } from "@raycast/api";

const run = promisify(execFile);

const DEFAULT_CLI_PATH = "~/bin/trello-todo";
const TIMEOUT_MS = 30_000;
const MAX_BUFFER_BYTES = 10 * 1024 * 1024;

export interface Card {
  id: string;
  name: string;
  url: string;
}

export interface TrelloList {
  id: string;
  name: string;
  cards: Card[];
}

export interface Board {
  default_list: string;
  done_list: string;
  lists: TrelloList[];
}

function expandHome(path: string): string {
  return path.startsWith("~") ? homedir() + path.slice(1) : path;
}

function cliPath(): string {
  const configured = getPreferenceValues<Preferences>().cliPath?.trim();
  return expandHome(configured || DEFAULT_CLI_PATH);
}

async function runCli(args: string[]): Promise<string> {
  try {
    const { stdout } = await run(cliPath(), args, {
      timeout: TIMEOUT_MS,
      maxBuffer: MAX_BUFFER_BYTES,
      env: { ...process.env, NO_COLOR: "1" },
    });
    return stdout.trim();
  } catch (error) {
    const failure = error as { stderr?: string; message: string };
    throw new Error(failure.stderr?.trim() || failure.message);
  }
}

export async function fetchBoard(): Promise<Board> {
  return JSON.parse(await runCli(["--show", "--json"])) as Board;
}

export const addCard = (title: string, list: string) => runCli(["--add", title, "-l", list]);
export const moveCard = (cardId: string, list: string) => runCli(["--move", cardId, list]);
export const finishCard = (cardId: string) => runCli(["--done", cardId]);
export const renameCard = (cardId: string, title: string) => runCli(["--rename", cardId, title]);
export const deleteCard = (cardId: string) => runCli(["--delete", cardId]);
