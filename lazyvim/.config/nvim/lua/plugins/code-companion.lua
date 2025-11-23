return {
  "olimorris/codecompanion.nvim",
  opts = {
    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = "Prompt ",
        provider = "snacks", -- Use snacks for the action palette
        opts = {
          show_default_actions = true,
          show_default_prompt_library = true,
          title = "CodeCompanion actions",
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.diff",
  },
}
