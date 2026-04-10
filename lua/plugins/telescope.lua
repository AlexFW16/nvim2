return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    -- you can also tweak telescope config here if needed
    return opts
  end,
  keys = {
    {
      "<leader>fd",
      function()
        require("telescope.builtin").diagnostics({ bufnr = 0 })
      end,
      desc = "Find diagnostics (buffer)",
    },
    {
      "<leader>fD",
      function()
        require("telescope.builtin").diagnostics()
      end,
      desc = "Find diagnostics (workspace)",
    },
  },
}
