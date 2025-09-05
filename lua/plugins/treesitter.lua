return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "dlvandenberg/tree-sitter-angular",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      ensure_installed = {
        "typescript",
        "html",
        "css",
        "scss",
        "javascript",
        "angular",
      },
      highlight = { enable = true },
      indent = { enable = true },

      -- enable autotagging (w/nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      auto_install = true,

      -- Add these so Lua LS shuts up
      modules = {}, -- default empty
      sync_install = false, -- default
      ignore_install = {}, -- default

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })

    -- Use angular parser for *.component.html but keep filetype as html
    local ts_parsers = require("nvim-treesitter.parsers")
    local parser_config = ts_parsers.get_parser_configs()
    parser_config.angular.used_by = { "html" }

    vim.api.nvim_create_autocmd("BufRead", {
      pattern = "*.component.html",
      callback = function()
        vim.treesitter.start(0, "angular")
      end,
    })
  end,
}
