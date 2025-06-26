-- There are two differnt versions of night-owl for vim
-- The haishanh version doesn't do syntax highlighting well with treesitter

-- return {
--   "haishanh/night-owl.vim",
-- }

return {
  {
    "oxfist/night-owl.nvim",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "night-owl",
    },
  },
}
