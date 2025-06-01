-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false })
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

local tele_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ds", tele_builtin.lsp_document_symbols, { desc = "Document Symbols" })
vim.keymap.set("n", "<leader>fa", function()
  require("telescope.builtin").live_grep({
    cwd = require("lazyvim.util").root.get(), -- this ensures it uses the project root
  })
end, { desc = "Grep from project root" })
vim.keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Fuzzy find in buffer" })

require("no-neck-pain")
vim.keymap.set("n", "<leader>bg", ":NoNeckPain<CR>")

require("worktrees").setup()
vim.keymap.set("n", "<leader>gw", function()
  Snacks.picker.worktrees()
end)
