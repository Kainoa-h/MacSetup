return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- global LSP formatting options
      format = {
        timeout_ms = 5000, -- increase from default 1000ms to 5s
      },
    },
  },
}
