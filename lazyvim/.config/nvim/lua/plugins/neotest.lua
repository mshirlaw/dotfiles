return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = function(path)
            if path:match("/src/") then
              return "npm run test -w src -- --no-coverage --verbose"
            elseif path:match("/orchestrator/") then
              return "npm run test -w orchestrator -- --no-coverage --verbose"
            elseif path:match("/distributor/") then
              return "npm run test -w distributor -- --no-coverage --verbose"
            end
            return "npm test -- --no-coverage --verbose"
          end,
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
          jest_test_discovery = false,
        },
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
    },
  },
}
