return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    local dashboard = require("dashboard")
    dashboard.setup()
  end,
}
