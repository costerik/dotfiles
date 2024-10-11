return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore = false,
      suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })
    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session" })
    keymap.set("n", "<leader>wS", "<cmd>SessionSearch<CR>", { desc = "Session search" })
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session" })
    keymap.set("n", "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", { desc = "Toggle autosave" })
  end,
}
