return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Detect if project uses oxlint
    local function has_oxlint()
      local cwd = vim.fn.getcwd()
      -- Check for oxlint config files
      local oxlint_configs = {
        "/.oxlintrc.json",
        "/.oxlint.json",
        "/.oxlintrc.api.json",
        "/.oxlintrc.root.json",
        "/.oxlintrc.root.js",
      }
      for _, config in ipairs(oxlint_configs) do
        if vim.fn.filereadable(cwd .. config) == 1 then
          return true
        end
      end
      -- Check package.json for oxlint dependency
      local pkg_path = cwd .. "/package.json"
      if vim.fn.filereadable(pkg_path) == 1 then
        local content = vim.fn.readfile(pkg_path)
        local json_str = table.concat(content, "")
        if json_str:match('"oxlint"') then
          return true
        end
      end
      return false
    end

    -- Detect if project uses eslint
    local function has_eslint()
      local cwd = vim.fn.getcwd()
      local eslint_configs = {
        "/.eslintrc.js",
        "/.eslintrc.cjs",
        "/.eslintrc.mjs",
        "/.eslintrc.json",
        "/.eslintrc.yml",
        "/.eslintrc.yaml",
        "/.eslintrc",
        "/.eslintrc.api.js",
        "/.eslintrc.js",
        "/.eslintrc.root.js",
        "/eslint.config.js",
        "/eslint.config.mjs",
        "/eslint.config.cjs",
      }
      for _, config in ipairs(eslint_configs) do
        if vim.fn.filereadable(cwd .. config) == 1 then
          return true
        end
      end
      -- Check package.json for eslintConfig key or eslint dependency
      local pkg_path = cwd .. "/package.json"
      if vim.fn.filereadable(pkg_path) == 1 then
        local content = vim.fn.readfile(pkg_path)
        local json_str = table.concat(content, "")
        if json_str:match('"eslintConfig"') or json_str:match('"eslint"') then
          return true
        end
      end
      return false
    end

    -- Resolve eslint_d or eslint binary
    local function eslint_cmd()
      local cwd = vim.fn.getcwd()
      local local_eslint_d = cwd .. "/node_modules/.bin/eslint_d"
      local local_eslint = cwd .. "/node_modules/.bin/eslint"
      if vim.fn.executable(local_eslint_d) == 1 then
        return local_eslint_d
      elseif vim.fn.executable(local_eslint) == 1 then
        return local_eslint
      else
        return "eslint_d"
      end
    end

    ---@diagnostic disable-next-line: assign-type-mismatch
    lint.linters.eslint_d.cmd = eslint_cmd

    -- Resolve linters dynamically per buffer
    local function get_js_linters()
      local linters = {}
      if has_oxlint() then
        table.insert(linters, "oxlint")
      end
      if has_eslint() then
        table.insert(linters, "eslint_d")
      end
      -- Fallback: if neither config found, default to eslint_d
      if #linters == 0 then
        table.insert(linters, "eslint_d")
      end
      return linters
    end

    local js_filetypes = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "svelte",
      "html",
    }

    -- Build linters_by_ft dynamically
    lint.linters_by_ft = {
      python = { "pylint" },
    }

    for _, ft in ipairs(js_filetypes) do
      lint.linters_by_ft[ft] = get_js_linters()
    end

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- Re-evaluate linters on each trigger to handle cwd changes
        local ft = vim.bo.filetype
        local js_ft_set = {}
        for _, f in ipairs(js_filetypes) do
          js_ft_set[f] = true
        end
        if js_ft_set[ft] then
          lint.linters_by_ft[ft] = get_js_linters()
        end
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>li", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
