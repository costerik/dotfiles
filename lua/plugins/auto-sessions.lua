return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    auto_restore = false,
    suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    bypass_save_filetypes = { "dashboard" },

    session_lens = {
      load_on_setup = true,
      previewer = "summary",
    },
  },
  keys = {
    { "<leader>wr", "<cmd>AutoSession restore<CR>", desc = "Restore session" },
    { "<leader>wS", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
    { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
  },
}
