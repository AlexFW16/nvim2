-- @description: Snacks.nvim configuration
-- Removes common directories from file and grep pickers
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          exclude = {
            "node_modules",
            "dist",
            "build",
            ".git",
          },
        },
        grep = {
          exclude = {
            "node_modules",
            "dist",
            "build",
            ".git",
          },
        },
      },
    },
  },
}
