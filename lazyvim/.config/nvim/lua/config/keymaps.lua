-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local map = vim.keymap.set

-- map("n", "<leader>yr", '<cmd>let @+ = expand("%")<cr>', { desc = "Yank relative path" })
-- map("n", "<leader>yf", '<cmd>let @+ = expand("%:p")<cr>', { desc = "Yank full path" })

local wk = require("which-key")

wk.register({
  y = {
    name = "yank",
    r = { '<cmd>let @+ = expand("%")<cr>', "Relative path" },
    f = { '<cmd>let @+ = expand("%:p")<cr>', "Full path" },
  },
}, { prefix = "<leader>" })
