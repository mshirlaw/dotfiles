# AGENTS.md

This file is intentionally thin.

The canonical shared repository guidelines are in [docs/GUIDELINES.md](docs/GUIDELINES.md). Read and follow that file first.

## Critical Rules (Duplicated Here)

- Never commit secrets, tokens, passwords, or private keys.
- Never run destructive commands (for example: `rm -rf`, `git reset --hard`, `git checkout --`) unless explicitly requested.
- Never revert unrelated local changes you did not make.
- Use preview-first workflows for stow changes (`stow -n` before `stow`/`stow -R`).

## Codex-Specific Notes

- Prefer `rg` and `rg --files` for search.
- Keep edits minimal and aligned with existing repository conventions.
