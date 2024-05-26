return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    -- Install shellcheck and shfmt
    -- https://github.com/koalaman/shellcheck
    -- https://github.com/mvdan/sh
    "gbprod/none-ls-shellcheck.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local formatting = null_ls.builtins.formatting

    null_ls.setup({
      sources = {
        formatting.stylua,
        formatting.prettier,
        require("none-ls.code_actions.eslint"),
        require("none-ls.diagnostics.eslint"),
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls-shellcheck.code_actions"),
        null_ls.builtins.formatting.shfmt.with({
          filetypes = { "sh", "zsh" },
        }),
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
              -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
              vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
            end,
          })
        end
      end,
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format file or range (in visual mode)" })
  end,
}
