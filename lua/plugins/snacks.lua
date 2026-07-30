-- @description: Snacks.nvim configuration
-- Removes common directories from file and grep pickers
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      main = { current = true },
      sources = {
        grep = {
          exclude = require("constants").exclude_dirs,
        },
        notifications = {
          confirm = function(picker, item)
            if item and item.item then
              vim.fn.setreg("+", item.item.msg)
              require("snacks").notify.info "Notification copied to clipboard"
            end
            picker:close()
          end,
        },
      },
    },
  },
}
