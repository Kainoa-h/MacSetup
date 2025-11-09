-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- require("catppuccin").load("latte")
-- vim.o.background = "light"
-- vim.cmd([[colorscheme gruvbox]])

vim.o.background = "dark"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1
-- vim.cmd("colorscheme gruvbox-material")

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

require("project_nvim").setup({
  manual_mode = false,
  detection_methods = { "pattern" },
  patterns = { ".git", "Makefile", "package.json" }, -- feel free to add more
})

local venv = vim.fn.getcwd() .. "/.venv/bin/python"
local python_path
if vim.fn.executable(venv) == 1 then
  python_path = venv
else
  python_path = "/opt/homebrew/bin/python3.11"
end

require("lspconfig").pyright.setup({
  settings = {
    python = {
      pythonPath = python_path,
    },
  },
})
