return {
  "sudo-tee/opencode.nvim",
  dependencies = {
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
      ft = {
        "markdown",
        "Avante",
        "copilot-chat",
        "opencode_output",
      },
    },
    "saghen/blink.cmp",
    "folke/snacks.nvim",
  },

  config = function()
    require("opencode").setup {
      preferred_picker = "snacks",
      default_global_keymaps = true,
      default_mode = "plan",
      keymap_prefix = "<C-x>",
      opencode_executable = "opencode",

      keymap = {
        editor = {
          -- Main controls
          ["<C-p>"] = {
            "toggle",
            mode = { "n", "i" },
            desc = "Toggle OpenCode window",
          },
          ["<leader>oi"] = false,
          ["<leader>oI"] = false,
          ["<C-S-p>"] = {
            "open_input_new_session",
            desc = "Open input in a new session",
          },
          ["<leader>oo"] = {
            "open_output",
            desc = "Open output window",
          },
          ["<leader>ot"] = {
            "toggle_focus",
            desc = "Toggle focus",
          },
          ["<leader>oT"] = {
            "timeline",
            desc = "Open session timeline",
          },
          ["<leader>oq"] = {
            "close",
            desc = "Close OpenCode window",
          },
          ["<leader>os"] = {
            "select_session",
            desc = "Select session",
          },
          ["<leader>oR"] = {
            "rename_session",
            desc = "Rename session",
          },

          -- Session tabs: navigate like Neovim buffers (but not outside of opencode)
          ["[b"] = false,
          ["]b"] = false,

          -- Model settings
          ["<leader>op"] = {
            "configure_provider",
            desc = "Configure provider",
          },
          ["<leader>oV"] = {
            "configure_variant",
            desc = "Configure model variant",
          },

          -- Context
          ["<leader>oy"] = {
            "add_visual_selection",
            mode = { "v" },
            desc = "Add visual selection to context",
          },
          ["<leader>oY"] = {
            "add_visual_selection_inline",
            mode = { "v" },
            desc = "Insert selection into input",
          },

          -- Layout and diffs
          ["<leader>oz"] = {
            "toggle_zoom",
            desc = "Toggle zoom",
          },
          ["<leader>ov"] = {
            "paste_image",
            desc = "Paste image from clipboard",
          },
          ["<leader>od"] = {
            "diff_open",
            desc = "Open diff view",
          },
          ["<leader>o]"] = {
            "diff_next",
            desc = "Next diff",
          },
          ["<leader>o["] = {
            "diff_prev",
            desc = "Previous diff",
          },
          ["<leader>oc"] = {
            "diff_close",
            desc = "Close diff view",
          },

          -- Revert changes
          ["<leader>ora"] = {
            "diff_revert_all_last_prompt",
            desc = "Revert all changes from last prompt",
          },
          ["<leader>ort"] = {
            "diff_revert_this_last_prompt",
            desc = "Revert last prompt change",
          },
          ["<leader>orA"] = {
            "diff_revert_all",
            desc = "Revert all changes",
          },
          ["<leader>orT"] = {
            "diff_revert_this",
            desc = "Revert this change",
          },
          ["<leader>orr"] = {
            "diff_restore_snapshot_file",
            desc = "Restore file snapshot",
          },
          ["<leader>orR"] = {
            "diff_restore_snapshot_all",
            desc = "Restore all snapshots",
          },

          ["<leader>ox"] = {
            "swap_position",
            desc = "Swap window position",
          },
          ["<leader>ott"] = {
            "toggle_tool_output",
            desc = "Toggle tool output",
          },
          ["<leader>otr"] = {
            "toggle_reasoning_output",
            desc = "Toggle reasoning output",
          },

          -- Use Ctrl+A instead of the default leader mapping
          ["<leader>o/"] = false,
          ["<C-a>"] = {
            "quick_chat",
            mode = { "n", "x" },
            desc = "Quick chat with current context",
          },
        },

        input_window = {
          -- Keep Enter available for normal input/submission behavior
          ["<cr>"] = {
            "submit_input_prompt",
            mode = { "i", "n" },
            desc = "Submit prompt",
          },
          ["~"] = {
            "mention_file",
            mode = { "i" },
            desc = "Mention file in context",
          },
          ["@"] = {
            "mention",
            mode = { "i" },
            desc = "Open mention picker",
          },
          ["/"] = {
            "slash_commands",
            mode = { "i" },
            desc = "Open slash commands",
          },
          ["#"] = {
            "context_items",
            mode = { "i" },
            desc = "Open context items",
          },
          ["<M-v>"] = {
            "paste_image",
            mode = { "i" },
            desc = "Paste image",
          },
          ["<tab>"] = {
            "toggle_pane",
            mode = { "n", "i" },
            defer_to_completion = true,
            desc = "Toggle input/output panes",
          },
          ["<up>"] = {
            "prev_prompt_history",
            mode = { "n", "i" },
            defer_to_completion = true,
            desc = "Previous prompt history item",
          },
          ["<down>"] = {
            "next_prompt_history",
            mode = { "n", "i" },
            defer_to_completion = true,
            desc = "Next prompt history item",
          },
          ["<M-m>"] = {
            "switch_mode",
            mode = { "n", "i" },
            desc = "Switch agent mode",
          },
          ["<M-r>"] = {
            "cycle_variant",
            mode = { "n", "i" },
            desc = "Cycle model variants",
          },
          ["<esc>"] = false,

          ["<C-p>"] = {
            "toggle",
            mode = { "n", "i" },
            defer_to_completion = false,
            desc = "Toggle OpenCode window",
          },

          ["[b"] = {
            "prev_session_tab",
            mode = { "n" },
            desc = "Previous OpenCode tab",
          },
          ["]b"] = {
            "next_session_tab",
            mode = { "n" },
            desc = "Next OpenCode tab",
          },

          ["<leader>n"] = {
            "open_session_tab",
            mode = { "n" },
            desc = "New OpenCode tab",
          },
          ["<leader>c"] = {
            "close_session_tab",
            mode = { "n" },
            desc = "Close OpenCode tab",
          },
        },

        output_window = {
          -- Explicitly disable the default Escape-to-close behavior
          ["<esc>"] = false,

          ["<C-p>"] = {
            "toggle",
            mode = { "n" },
            desc = "Toggle OpenCode window",
          },
          ["<C-c>"] = {
            "cancel",
            desc = "Cancel running request",
          },
          ["]]"] = {
            "next_message",
            desc = "Next message",
          },
          ["[["] = {
            "prev_message",
            desc = "Previous message",
          },
          ["<tab>"] = {
            "toggle_pane",
            mode = { "n", "i" },
            desc = "Toggle input/output panes",
          },
          ["i"] = {
            "focus_input",
            mode = { "n" },
            desc = "Focus input window",
          },
          ["gf"] = {
            "jump_to_file",
            mode = { "n" },
            desc = "Jump to file",
          },
          ["<M-r>"] = {
            "cycle_variant",
            mode = { "n" },
            desc = "Cycle model variants",
          },

          ["<leader>oD"] = {
            "debug_message",
            desc = "Open raw message debug view",
          },
          ["<leader>oO"] = {
            "debug_output",
            desc = "Open raw output debug view",
          },
          ["<leader>ods"] = {
            "debug_session",
            desc = "Open raw session debug view",
          },
        },
      },

      ui = {
        enable_treesitter_markdown = true,
        position = "right",
        input_position = "bottom",
        window_width = 0.40,
        zoom_width = 0.8,

        display_model = true,
        display_context_size = true,
        display_cost = true,

        window_highlight = "Normal:OpencodeBackground,FloatBorder:OpencodeBorder",
        persist_state = true,

        icons = {
          preset = "nerdfonts",
          overrides = {},
        },

        questions = {
          use_vim_ui_select = false,
          inline_other_input = true,
        },

        output = {
          filetype = "opencode_output",
          compact_assistant_headers = false,

          tools = {
            show_output = true,
            show_reasoning_output = true,
            use_folds = true,
            folding_threshold = 25,
            fold_exclude = {
              "bash",
              {
                server = "sequential-thinking",
                tool = "sequentialthinking",
              },
            },
          },

          rendering = {
            markdown_debounce_ms = 250,
          },
        },

        input = {
          min_height = 0.10,
          max_height = 0.25,
          text = {
            wrap = false,
          },
          auto_hide = false,
        },

        picker = {
          snacks_layout = nil,
        },
      },

      context = {
        enabled = true,

        cursor_data = {
          enabled = false,
          context_lines = 5,
        },

        diagnostics = {
          enabled = true,
          info = true,
          warning = true,
          error = true,
          only_closest = false,
        },

        current_file = {
          enabled = true,
          show_full_path = true,
        },

        files = {
          enabled = true,
          show_full_path = true,
        },

        selection = {
          enabled = true,
        },

        buffer = {
          enabled = false,
        },

        git_diff = {
          enabled = false,
        },

        -- review_comments and agents retain the new defaults
      },

      logging = {
        enabled = false,
        level = "warn",
      },

      child_readonly = true,
    }
  end,
}
