-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- require("catppuccin").load("latte")
-- vim.o.background = "light"
-- vim.cmd([[colorscheme gruvbox]])

vim.o.background = "dark"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1
vim.cmd("colorscheme gruvbox-material")

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
