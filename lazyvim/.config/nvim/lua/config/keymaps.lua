-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local map = vim.keymap.set

-- map("n", "<leader>yr", '<cmd>let @+ = expand("%")<cr>', { desc = "Yank relative path" })
-- map("n", "<leader>yf", '<cmd>let @+ = expand("%:p")<cr>', { desc = "Yank full path" })

local wk = require("which-key")

-- Add some yank mappings

wk.add({
  { "<leader>y", group = "yank" },
  { "<leader>yf", '<cmd>let @+ = expand("%:p")<cr>', desc = "Full path" },
  { "<leader>yr", '<cmd>let @+ = expand("%")<cr>', desc = "Relative path" },
})

-- Add some copilot mappings

-- currently the TAB binding is used by something else so
-- unless we set a custom binding, we can't use it
vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})

-- Add some CodeCompanion mappings

wk.add({
  { "<leader>a", group = "CodeCompanion" },
  { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat", mode = { "n", "v" } },
  { "<leader>ai", ":'<,'>CodeCompanion<cr>", desc = "Inline Assistant", mode = "v" },
  { "<leader>ag", "<cmd>CodeCompanionActions<cr>", desc = "Actions", mode = { "n", "v" } },
})
