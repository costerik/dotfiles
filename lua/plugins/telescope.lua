return {
  "nvim-telescope/telescope.nvim",
  branch = "master", -- https://github.com/nvim-telescope/telescope.nvim/issues/3469
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
      },
    })

    telescope.load_extension("fzf")

    local builtin = require("telescope.builtin")

    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd " })
    keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fS", builtin.current_buffer_fuzzy_find, { desc = "Find string in current buffer" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fn", "<cmd>Telescope notify<cr>", { desc = "Show notitications history" })
  end,
}
