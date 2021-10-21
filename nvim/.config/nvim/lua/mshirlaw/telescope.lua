local M = {}

M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< Dotfiles >",
        cwd = '~/dotfiles/nvim',
        hidden = true,
    })
end

M.search_notes = function()
    require("telescope.builtin").find_files({
        prompt_title = "< Notes >",
        cwd = '~/notes',
        hidden = true,
    })
end

return M