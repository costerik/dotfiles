return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    -- Detect if project uses oxlint/oxc toolchain (oxfmt)
    local function has_oxfmt()
      local cwd = vim.fn.getcwd()
      if vim.fn.filereadable(cwd .. "/.oxfmtrc.json") == 1 then
        return true
      end
      return false
    end

    -- Detect if project uses prettier
    local function has_prettier()
      local cwd = vim.fn.getcwd()
      local prettier_configs = {
        "/.prettierrc",
        "/.prettierrc.js",
        "/.prettierrc.cjs",
        "/.prettierrc.mjs",
        "/.prettierrc.json",
        "/.prettierrc.json5",
        "/.prettierrc.yml",
        "/.prettierrc.yaml",
        "/.prettierrc.toml",
        "/prettier.config.js",
        "/prettier.config.cjs",
        "/prettier.config.mjs",
      }
      for _, config in ipairs(prettier_configs) do
        if vim.fn.filereadable(cwd .. config) == 1 then
          return true
        end
      end
      -- Check package.json for prettier key or dependency
      local pkg_path = cwd .. "/package.json"
      if vim.fn.filereadable(pkg_path) == 1 then
        local content = vim.fn.readfile(pkg_path)
        local json_str = table.concat(content, "")
        if json_str:match('"prettier"') then
          return true
        end
      end
      return false
    end

    -- oxfmt only supports JS/TS family
    local oxfmt_filetypes = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "svelte",
    }

    local function get_js_formatters()
      local formatters = {}
      if has_oxfmt() then
        table.insert(formatters, "oxfmt")
      end
      if has_prettier() then
        table.insert(formatters, "prettier")
      end
      -- Fallback: neither config found, default to prettier
      if #formatters == 0 then
        table.insert(formatters, "prettier")
      end
      return formatters
    end

    -- Build formatters_by_ft dynamically
    local formatters_by_ft = {
      -- prettier-only filetypes (oxfmt does not support these)
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      liquid = { "prettier" },
      -- non-JS ecosystems
      lua = { "stylua" },
      python = { "isort", "black" },
    }

    local js_formatters = get_js_formatters()
    for _, ft in ipairs(oxfmt_filetypes) do
      formatters_by_ft[ft] = js_formatters
    end

    conform.setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = {
        lsp_fallback = true,
        async = true,
        timeout_ms = 2000,
      },
    })

    -- Re-evaluate JS formatters on DirChanged (project switch)
    vim.api.nvim_create_autocmd("DirChanged", {
      callback = function()
        local new_js_formatters = get_js_formatters()
        for _, ft in ipairs(oxfmt_filetypes) do
          conform.formatters_by_ft[ft] = new_js_formatters
        end
      end,
    })

    vim.keymap.set({ "n", "v" }, "<leader>gf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
