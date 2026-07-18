local lspconfig = require "lspconfig"

-- 1) Global diagnostics config
vim.diagnostic.config {
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    spacing = 4,
  },
  signs = true,
  underline = false,
  update_in_insert = false,
}

-- 2) Floating diagnostics severity
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { severity_limit = "Warning" })

-- 3) SWI-Prolog LSP setup (CORRECT)
lspconfig.prolog_ls.setup {
  cmd = {
    "swipl",
    "-g",
    "use_module(library(lsp_server)).",
    "-g",
    "lsp_server:main",
    "-t",
    "halt",
    "--",
    "stdio",
  },

  filetypes = { "prolog" },

  root_dir = function(fname) return lspconfig.util.root_pattern ".git"(fname) or vim.fn.getcwd() end,
}
