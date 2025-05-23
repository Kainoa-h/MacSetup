return {
  "LazyVim/LazyVim",
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    opts = {
      buffers = {
        right = { enabled = false },
        scratchPad = {
          enabled = true,
          location = "~/Documents/",
        },
        bo = {
          filetype = "md",
        },
      },
    },
  },
}
