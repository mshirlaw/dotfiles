-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local map = vim.keymap.set

-- map("n", "<leader>yr", '<cmd>let @+ = expand("%")<cr>', { desc = "Yank relative path" })
-- map("n", "<leader>yf", '<cmd>let @+ = expand("%:p")<cr>', { desc = "Yank full path" })

local wk = require("which-key")

wk.add({
  { "<leader>y", group = "yank" },
  { "<leader>yf", '<cmd>let @+ = expand("%:p")<cr>', desc = "Full path" },
  { "<leader>yr", '<cmd>let @+ = expand("%")<cr>', desc = "Relative path" },
})

-- currently the TAB binding is used by something else so
-- unless we set a custom binding, we can't use it
vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true



