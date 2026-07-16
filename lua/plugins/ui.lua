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
        overrides = function(c)
          local panel = "#252d3a" -- dark slate blue: visible but still dark, fits cyberdream's cool palette
          return {
            WinSeparator = { fg = c.purple, bg = "NONE" },

            NormalFloat = { bg = panel },
            FloatBorder = { fg = c.cyan, bg = panel },

            Pmenu = { bg = panel },
            PmenuBorder = { fg = c.purple, bg = panel },
            PmenuSel = { bg = c.bg_highlight, fg = c.cyan, bold = true },

            TelescopeNormal = { bg = panel },
            TelescopeBorder = { fg = c.magenta, bg = panel },
            TelescopePromptBorder = { fg = c.cyan, bg = panel },
            TelescopeResultsBorder = { fg = c.purple, bg = panel },
            TelescopePreviewBorder = { fg = c.pink, bg = panel },

            SnacksPicker = { bg = panel },
            SnacksPickerBorder = { fg = c.magenta, bg = panel },
            SnacksPickerInput = { bg = panel },
            SnacksPickerInputBorder = { fg = c.cyan, bg = panel },
            SnacksPickerTitle = { bg = panel, fg = c.purple, bold = true },
          }
        end,
      })

      vim.cmd.colorscheme("cyberdream")

      vim.opt.winblend = 0
      vim.opt.pumblend = 0

      local hl = vim.api.nvim_set_hl
      hl(0, "Normal", { bg = "none" })
      hl(0, "SignColumn", { bg = "none" })
      hl(0, "EndOfBuffer", { bg = "none" })
    end,
  },
}

