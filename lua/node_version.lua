-- Force Neovim to use nvm-managed Node and not old system version
local nvm_node = os.getenv "HOME" .. "/.nvm/versions/node/v22.21.1/bin"

vim.env.PATH = nvm_node .. ":" .. vim.env.PATH
vim.env.NODE_PATH = nvm_node
