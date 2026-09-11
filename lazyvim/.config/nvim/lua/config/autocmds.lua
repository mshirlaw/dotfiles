-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Auto-reload buffers when files change on disk
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env", ".env.*", "*.env" },
  callback = function()
    vim.bo.filetype = "dotenv"
  end,
})

-- Ensure ESLint auto-fixes (including code-action-based fixes) run on save.
local eslint_fix_group = vim.api.nvim_create_augroup("LazyVimEslintFixAllOnSave", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "eslint" then
      return
    end

    vim.api.nvim_clear_autocmds({ group = eslint_fix_group, buffer = args.buf })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = eslint_fix_group,
      buffer = args.buf,
      command = "silent! LspEslintFixAll",
    })
  end,
})
