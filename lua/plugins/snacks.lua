-- @description: Snacks.nvim configuration
-- Removes common directories from file and grep pickers
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      main = { current = true },
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
        notifications = {
          confirm = function(picker, item)
            if item and item.item then
              vim.fn.setreg("+", item.item.msg)
              Snacks.notify.info("Notification copied to clipboard")
            end
            picker:close()
          end,
        },
      },
    },
  },
}
