
-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    -- opts = {
    --   dashboard = {
    --     enabled =false,
    --     preset = {
    --       header = table.concat({
    --     "      ██████           ██     ██  ██  ██       ██",
    --     "     ██    ██          ██     ██  ██  ███     ███",
    --     "     ██    ██  ██  ██   ██   ██   ██  ██ ██ ██ ██",
    --     "     ██    ██    ██      ██ ██    ██  ██  ██   ██",
    --     "      ██████   ██  ██     ███     ██  ██       ██",
    --       }, "\n"),
    --     },
    --   },
    -- },
  },

{
  "goolord/alpha-nvim",
  dependencies = { "nvim-mini/mini.icons" },
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")dashboard.section.header.val = {
    "                                                      ",
    "     ██████╗   ██╗  ██╗  ██╗   ██╗  ██╗  ███╗   ███╗  ",
    "    ██╔═████╗  ╚██╗██╔╝  ██║   ██║  ██║  ████╗ ████║  ",
    "    ██║██╔██║   ╚███╔╝   ██║   ██║  ██║  ██╔████╔██║ ",
    "    ████╔╝██║   ██╔██╗   ╚██╗ ██╔╝  ██║  ██║╚██╔╝██║ ",
    "    ╚██████╔╝  ██╔╝ ██╗   ╚████╔╝   ██║  ██║ ╚═╝ ██║  ",
    "     ╚═════╝   ╚═╝  ╚═╝    ╚═══╝    ╚═╝  ╚═╝     ╚═╝  ",
    "                                                      ",
    "                        AlexFW                         ",
    "                                                      ",
}      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
        dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
        dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
      }

-- Completely customize the layout to ONLY show the header centered
    dashboard.config.layout = {
      { type = "padding", val = 26 }, -- Adds blank lines at the top to center it vertically
      dashboard.section.header,
    }

    alpha.setup(dashboard.config)
  end,
  },

-- (hopefully) overrides the default options of the included telescope plugin
{
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      if not opts.defaults then opts.defaults = {} end

      -- Solid panel background (winblend conflicts with explicit bg colors)
      opts.defaults.winblend = 0

      -- Fixes layout hijacking when opening files from the dashboard/empty windows
      opts.defaults.get_selection_window = function()
        local current_win = vim.api.nvim_get_current_win()
        local current_buf = vim.api.nvim_win_get_buf(current_win)
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = current_buf })
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = current_buf })

        if buftype == "terminal" or filetype == "toggleterm" then
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local bt = vim.api.nvim_get_option_value("buftype", { buf = buf })
            local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
            if bt ~= "terminal" and ft ~= "toggleterm" and ft ~= "qf" then
              return win
            end
          end
        end

        return current_win
      end

      return opts -- Crucial fix for AstroNvim
    end,
  },  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })

      -- include the default astronvim config that calls the setup call
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup {
        app = "browser",
      }
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

  -- themes

  {
    "morhetz/gruvbox",
    name = "gruvbox",
    priority = 1000,
    config = function()
      vim.g.gruvbox_vert_split = "red"
      vim.g.gruvbox_transparent_bg = true
    end,
    --, gruvbox_contrast_dark = 'hard'
  },

  { "catppuccin/nvim", name = "catppuccin", priority = 999 },
{
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
--NOTE: config in ui.lua
},

  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.keymap.set("i", "<C-e>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
      -- vim.cmd [[highlight CopilotSuggestion guifg=#a08060    ctermfg=203]]
      vim.cmd [[highlight CopilotSuggestion guifg=#a06e56     ctermfg=203]]
    end,
  },

  {
    "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git",
    -- Activate when a file is created/opened
    event = { "BufReadPre", "BufNewFile" },
    -- Activate when a supported filetype is open
    ft = { "go", "javascript", "python", "ruby" },
    cond = function()
      -- Only activate if token is present in environment variable.
      -- Remove this line to use the interactive workflow.
      return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ""
    end,
    opts = {
      statusline = {
        -- Hook into the built-in statusline to indicate the status
        -- of the GitLab Duo Code Suggestions integration
        enabled = true,
      },
    },
  },
  -- Prolog integration
  { "mxw/vim-prolog" },

  -- statusline
  {
    "windwp/windline.nvim",
    config = function()
      require "wlsample.airline" -- animations/colors
      -- vim.schedule(function()
      --   require("plugins.statusline").setup() -- only called **after windline is loaded**
      -- end)
    end,
  },

  {
    "toppair/peek.nvim",
    config = function()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
      require("peek").setup {
        app = "browser",
      }
    end,
  },

  -- when moving smth in neo-tree, the cursor is
  -- set to the first slash before the filename
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    -- opts = {filesystem ={ renderer = { components = {"icon", "name", "size"}}}}, -- Would always expand size to show everything (like pressing e)
    config = function()
      require("neo-tree").setup {
        -- custom command to show all file infos
        filesystem = {
          window = {
            mappings = {
              ["E"] = "expand_all_stats",
              ["Y"] = "copy_path_from_root",
            },
          },
          commands = {
            expand_all_stats = function(state)
              vim.notify(tostring(vim.api.nvim_win_get_width(vim.api.nvim_get_current_win())))

              if vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) >= 100 then
                require("neo-tree.sources.filesystem.commands").toggle_auto_expand_width(state)
                -- vim.api.nvim_win_set_width(state.winid, 100)
              else
                vim.api.nvim_win_set_width(state.winid, 100)
              end
              -- require"neo-tree.sources.filesystem.commands".open_vsplit(state)
            end,

            -- to copy path relative to root
            copy_path_from_root = function(state)
              local node = state.tree:get_node()
              if node.type ~= "file" and node.type ~= "directory" then return end
              local path = node.path
              local root = state.path
              if not root or root == "" then root = vim.loop.cwd() end
              local relative_path = string.sub(path, #root + 2)
              vim.fn.setreg("+", relative_path)
              vim.notify("Copied to clipboard: " .. relative_path)
            end,
          },
        },

        -- your other neo-tree options here (filesystem, default_component_configs, etc.)
        event_handlers = {
          {
            event = "neo_tree_popup_input_ready",
            handler = function(args)
              pcall(function()
                local bufnr, winid = args.bufnr, args.winid
                if not bufnr or not winid then return end

                -- read first line of popup buffer
                local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
                -- find last slash or backslash
                local pos
                for i = #line, 1, -1 do
                  local ch = line:sub(i, i)
                  if ch == "/" or ch == "\\" then
                    pos = i
                    break
                  end
                end

                local col = 0
                if pos then
                  -- pos is 1-based char index of slash; set col to pos to place cursor after slash
                  col = pos
                end

                -- schedule to avoid races with Nui/Neo-tree internals
                vim.schedule(function()
                  vim.api.nvim_win_set_cursor(winid, { 1, col })
                  -- if popup lost insert mode, re-enter insert (optional)
                  -- Exit insert mode if active
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
                  -- Start visual mode (selecting 1 char)
                  -- vim.api.nvim_feedkeys("v", "n", true)
                end)
              end)
            end,
          },
        },
      }
    end,
  },

  -- Plugin to highlight TODO:, NOTE: , ...
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = {
          icon = " ",
          color = "info",
          alt = { "todo" },
          highlight = {
            pattern = [[\c\btodo\b:?]],
          },
        },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "asdf" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
  },

  -- custom keymap to git diff against selected branch
  -- Map <leader>gD (Space g D) to open Telescope branch picker and diff
  {
    "tpope/vim-fugitive", -- required for :Gvdiffsplit
  },

  -- My own compac plugin
  {
    "AlexFW16/compac.nvim",
    config = function() require("compac").setup() end,
  },

  -- better visibility and context stuff
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      {
        -- needed so that barbecue works fine with get_icons
        "nvim-tree/nvim-web-devicons",
        config = function() require("nvim-web-devicons").setup() end,
      },
    },
    opts = {
      -- configurations go here
    },
  },
  -- diagnostics for the whole workspace, not just current file
{
  "artemave/workspace-diagnostics.nvim",
  event = "LspAttach",
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          require("workspace-diagnostics").populate_workspace_diagnostics(client, args.buf)
        end
      end,
    })
  end,
},
  -- Nice scrolling animation
 {
    "karb94/neoscroll.nvim",
    opts = {
      duration_multiplier = 0.1,
    },
},

  -- NOTE: Not used atm, used to automatically adjust widht of 
  -- current wndow
  -- {
  --   "anuvyklack/windows.nvim",
  --   dependencies={
  --     "anuvyklack/middleclass",
  --     -- "anuvyklack/animation.nvim"
  --   },
  --   config = function()
  --     -- vim.o.winwidth = 15
  --     -- vim.o.winminwidth = 12
  --     -- vim.o.equalalways = false
  --     require('windows').setup()
  --   end,
  -- },

  -- Opencode (AI code actions) 
  -- NOTE: implementation thats opencode focused, but trying out nvim ui focues alternative
-- {
--   "nickjvandyke/opencode.nvim",
--   version = "*", -- Latest stable release
--   dependencies = {
--     {
--       -- `snacks.nvim` integration is recommended, but optional
--       ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
--       "folke/snacks.nvim",
--       optional = true,
--       opts = {
--         input = {}, -- Enhances `ask()`
--         picker = { -- Enhances `select()`
--           actions = {
--             opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
--           },
--           win = {
--             input = {
--               keys = {
--                 ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
--               },
--             },
--           },
--         },
--       },
--     },
--   },
--   config = function()
--     ---@type opencode.Opts
--     vim.g.opencode_opts = {
--       server = {
--         start = function()
--           local cwd = vim.fn.getcwd()
--           local name = vim.fs.basename(cwd)
--           require("opencode.terminal").open(
--             ("docker run --rm -it -v %s:/repo -w /repo %s opencode --port"):format(cwd, name), {
--               split = "right",
--               width = math.floor(vim.o.columns * 0.35),
--             })
--         end,
--         toggle = function()
--           local cwd = vim.fn.getcwd()
--           local name = vim.fs.basename(cwd)
--           require("opencode.terminal").toggle(
--             ("docker run --rm -it -v %s:/repo -w /repo %s opencode --port"):format(cwd, name), {
--               split = "right",
--               width = math.floor(vim.o.columns * 0.35),
--             })
--         end,
--       },
--     }
--
--     vim.o.autoread = true -- Required for `opts.events.reload`
--
--     -- Recommended/example keymaps
--     vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
--     vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
--     vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })
--
--     vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
--     vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })
--
--     vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
--     vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })
--
--     -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
--     vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
--     vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
--   end,
--   },


  -- TODO: move to mappings?
  vim.keymap.set("n", "<leader>gD", function()
    -- Ensure fugitive is loaded
    require("telescope.builtin").git_branches {
      only_local = true, -- avoid duplicates
      attach_mapping
        = function(_, map)
        map("i", "<CR>", function(prompt_bufnr)
          ---@diagnostic disable-next-line: redundant-parameter
          local selection = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
          require("telescope.actions").close(prompt_bufnr)

          if vim.fn.exists ":Gvdiffsplit" > 0 then
            local branch = selection.value
            local file = vim.fn.expand "%" -- current file
            -- Use fugitive to diff current file vs selected branch
            vim.cmd("Gvdiffsplit " .. branch)
            -- Optionally notify user
            vim.notify("Diffing " .. file .. " vs branch " .. branch, vim.log.levels.INFO)
          else
            vim.notify("vim-fugitive not available or not in a git repo", vim.log.levels.ERROR)
          end
        end)
        return true
      end,
    }
  end, { desc = "Git diff against selected branch" }),

}
