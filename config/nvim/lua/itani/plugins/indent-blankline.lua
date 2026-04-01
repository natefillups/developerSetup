return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  main = "ibl",
  opts = {
    indent = { char = "│" },
    scope = { enabled = true },
  },
}
