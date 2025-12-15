return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- global LSP formatting options
      format = {
        timeout_ms = 5000, -- increase from default 1000ms to 5s
      },
      servers = {
        pyright = {
          on_new_config = function(new_config, _)
            local venv = vim.fn.getcwd() .. "/.venv/bin/python"
            if vim.fn.executable(venv) == 1 then
              new_config.settings.python.pythonPath = venv
            else
              new_config.settings.python.pythonPath = "/opt/homebrew/bin/python3.11"
            end
          end,
        },
        mojo = {
          cmd = { "pixi", "run", "mojo-lsp-server" },
          root_dir = function(fname)
            local git_dir = vim.fs.find(".git", { path = fname, upward = true })[1]
            return git_dir and vim.fs.dirname(git_dir) or vim.fn.getcwd()
          end,
          single_file_support = true,
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<leader>cf", function()
              vim.cmd("noa silent !pixi run mojo format --quiet " .. vim.fn.expand("%:p"))
            end, { buffer = bufnr, desc = "Format Mojo file" })
          end,
          filetypes = { "mojo" },
        },
      },
    },
  },
}
