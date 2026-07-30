# AGENTS.md

## What this is

AstroNvim v6 user configuration (not a plugin). Neovim config lives at `~/.config/nvim`.

## Boot sequence

`init.lua` -> `lua/node_version.lua` -> `lua/lazy_setup.lua` -> `lua/polish.lua`

lazy.nvim loads AstroNvim core, then `lua/community.lua` (currently disabled), then `lua/plugins/*.lua`.

## Linting & formatting

- **Formatter**: stylua (`.stylua.toml`): 2-space indent, no call parentheses, Unix line endings.
- **Linter**: selene (`selene.toml`, `neovim.yml` for globals).
- LSP formatting is explicitly disabled (`.luarc.json`, `.neoconf.json`). Always use `stylua` directly.

## Key conventions

- Leader = `Space`, LocalLeader = `,` (set in `lua/lazy_setup.lua` before lazy.nvim setup).
- `lua/community.lua` is intentionally disabled (early `return {}` guard). Do not remove the guard unless activating community packs.
- `lazy-lock.json` is gitignored. Never commit it.
- `lua/node_version.lua` hardcodes nvm Node v22.21.1 into PATH. Adjust there if node version changes.
- `lua/lsp.lua` has a manual SWI-Prolog LSP config but is currently not required from `init.lua` (commented out with a TODO).

## Shared constants

- `lua/constants.lua` exports a single `exclude_dirs` list used by snacks picker, grep, and neo-tree. Add new noisy directories there.

## Scratch folder

- `.scratch/` is gitignored. Throwaway test files go there.
- `<leader>ff` shows `.scratch/` files but excludes `node_modules`, `venv`, etc. (via `constants.exclude_dirs`).
- `<leader>fF` shows **all** files including gitignored — no exclusion.
- Neo-tree shows `.scratch/` files dimmed (gitignored); noisy dirs are fully hidden.

## Adding plugins

Create a file in `lua/plugins/`. Each file returns a lazy.nvim spec table. See existing files for the pattern.

## Verification

There is no test suite or CI. Verify changes by opening `nvim` and checking that it starts cleanly and the affected feature works.
