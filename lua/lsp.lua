-- 1) Diagnostics (modern API)
vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    spacing = 4,
  },
  signs = true,
  underline = false,
  update_in_insert = false,
})


-- 3) LSP config (new API)
vim.lsp.config("prolog_ls", {
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

  -- root_dir → root_markers (new style)
  root_markers = { ".git" },
})

-- 4) Enable LSP
vim.lsp.enable("prolog_ls")
