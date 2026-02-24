# CLAUDE.md

This file is intentionally thin.

The canonical shared repository guidelines are in [docs/GUIDELINES.md](docs/GUIDELINES.md). Read and follow that file first.

## Critical Rules (Duplicated Here)

- Never commit secrets, tokens, passwords, or private keys.
- Never run destructive commands (for example: `rm -rf`, `git reset --hard`, `git checkout --`) unless explicitly requested.
- Never revert unrelated local changes you did not make.
- Use preview-first workflows for stow changes (`stow -n` before `stow`/`stow -R`).

## Claude-Specific Rules

- **NEVER** add `Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>` to commit messages.
- Git commits should be authored by Matt Shirlaw `<matt.shirlaw@gmail.com>` only.
- Keep commit messages clean and professional without AI attribution.
