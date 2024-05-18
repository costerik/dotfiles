return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  version = "3.5.4",
  main = "ibl",
  opts = {
    indent = {
      char = "┊",
    },
  },
}
