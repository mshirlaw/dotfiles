import { Toast, showToast } from "@raycast/api";

export interface ToastMessages {
  progress: string;
  success: string;
  failure: string;
}

function errorMessage(error: unknown): string {
  return error instanceof Error ? error.message : String(error);
}

/**
 * Runs the work behind a progress toast and returns whether it succeeded.
 */
export async function runWithToast(messages: ToastMessages, work: () => Promise<unknown>): Promise<boolean> {
  const toast = await showToast({ style: Toast.Style.Animated, title: messages.progress });
  try {
    await work();
    toast.style = Toast.Style.Success;
    toast.title = messages.success;
    return true;
  } catch (error) {
    toast.style = Toast.Style.Failure;
    toast.title = messages.failure;
    toast.message = errorMessage(error);
    return false;
  }
}
