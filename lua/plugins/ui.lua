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
  -- config = function()
  --   require("cyberdream").setup({
  --     transparent = true,
  --     italic_comments = true,
  --     saturation = 0.9,
  --     overrides = function(c)
  --       return {
  --         -- Give borders neon colors, and panels a solid base to blend with
  --         WinSeparator = { fg = c.purple, bg = "NONE" }, 
  --
  --         NormalFloat = { bg = c.bg_alt },
  --         FloatBorder = { fg = c.cyan, bg = c.bg_alt },
  --
  --         Pmenu = { bg = c.bg_alt },
  --         PmenuBorder = { fg = c.purple, bg = c.bg_alt },
  --         PmenuSel = { bg = c.bg_highlight, fg = c.cyan, bold = true },
  --
  --         TelescopeNormal = { bg = c.bg_alt },
  --         TelescopeBorder = { fg = c.magenta, bg = c.bg_alt },
  --         TelescopePromptBorder = { fg = c.cyan, bg = c.bg_alt }, 
  --         TelescopeResultsBorder = { fg = c.purple, bg = c.bg_alt }, 
  --         TelescopePreviewBorder = { fg = c.pink, bg = c.bg_alt }, 
  --       }
  --     end,
  --   })
  --
  --   vim.cmd.colorscheme("cyberdream")
  --
  --   -- SEMI-TRANSPARENCY OPACITY (0 = Solid, 100 = Completely Clear)
  --   vim.o.pumblend = 15 -- Makes autocomplete dropdowns 15% transparent tinted glass
  -- end,

