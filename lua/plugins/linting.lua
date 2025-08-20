return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Function to dynamically resolve eslint/eslint_d
    local function eslint_cmd()
      local local_eslint_d = vim.fn.getcwd() .. "/node_modules/.bin/eslint_d"
      local local_eslint = vim.fn.getcwd() .. "/node_modules/.bin/eslint"
      if vim.fn.executable(local_eslint_d) == 1 then
        return local_eslint_d
      elseif vim.fn.executable(local_eslint) == 1 then
        return local_eslint
      else
        return "eslint_d" -- fallback to global
      end
    end

    ---@diagnostic disable-next-line: assign-type-mismatch
    lint.linters.eslint_d.cmd = eslint_cmd

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      html = { "eslint_d" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>li", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
