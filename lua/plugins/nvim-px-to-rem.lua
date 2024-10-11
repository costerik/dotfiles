return {
  "jsongerber/nvim-px-to-rem",
  config = true,
  --If you need to set some options replace the line above with:
  -- config = function()
  --     require('nvim-px-to-rem').setup()
  -- end,
  init = function()
    vim.api.nvim_set_keymap("n", "<leader>pxx", ":PxToRemCursor<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>pxl", ":PxToRemLine<CR>", { noremap = true })
  end,
}
