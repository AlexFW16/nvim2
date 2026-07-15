return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent = true,
        italic_comments = true,
        saturation = 0.9,
      })

      vim.cmd.colorscheme("cyberdream")

      -- UI “Verlauf” / glass effect
      vim.opt.winblend = 20
      vim.opt.pumblend = 20

      -- Core transparency layers
      local hl = vim.api.nvim_set_hl
      hl(0, "Normal", { bg = "none" })
      hl(0, "NormalFloat", { bg = "none" })
      hl(0, "SignColumn", { bg = "none" })
      hl(0, "EndOfBuffer", { bg = "none" })
    end,
  },
}
