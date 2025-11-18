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

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

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
end, { desc = "Switch Worktree" })

vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Start/Continue" })
vim.keymap.set("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Step Over" })

vim.keymap.set("n", "<C-S-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-S-k>", "<cmd>cprev<CR>")
