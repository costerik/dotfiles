local globalOptions = {
  -- netrw_liststyle = 3,   -- Change style of the explorer as a tree
  mapleader = " ", -- Update mapleader to space
}

for k, v in pairs(globalOptions) do
  vim.g[k] = v
end

local options = {
  autoindent = true,     -- copy indent of currrent line when starting new one
  backup = false,        -- creates a backup file
  cursorline = true,     -- highlight the current line
  errorbells = false,    -- Vim bells sounds off
  expandtab = true,      -- expands tab to spaces
  hlsearch = true,       -- highlight all matches on previous search pattern
  ignorecase = true,     -- ignore case when searching
  incsearch = false,     -- enable the incremental search feature
  mouse = "a",           -- allow the mouse to be used in neovim
  number = true,         -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  ruler = true,          -- displays the current cursor position in the status line at the bottom of the window
  scrolloff = 8,         -- is one of my fav
  shiftwidth = 2,        -- 2 spaces for indent width
  showtabline = 2,       -- always show tabs
  signcolumn = "yes",    -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,      -- smart case
  smartindent = true,    -- make indenting smarter again
  splitbelow = true,     -- force all horizontal splits to go below current window
  splitright = true,     -- force all vertical splits to go to the right of current window
  swapfile = false,      -- creates a swapfile
  tabstop = 2,           -- 2 spaces for tabs
  termguicolors = true,  -- set term gui colors (most terminals support this)
  undofile = true,       -- enable persistent undo
  wrap = false,          -- display lines as one long line
  writebackup = false,   -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

-- local optionsBackup = {
--   termguicolors = true,                    -- set term gui colors (most terminals support this)
--   backup = false,                          -- creates a backup file
--   clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
--   cmdheight = 2,                           -- more space in the neovim command line for displaying messages
--   completeopt = { "menuone", "noselect" }, -- mostly just for cmp
--   conceallevel = 0,                        -- so that `` is visible in markdown files
--   cursorline = true,                       -- highlight the current line
--   expandtab = true,                        -- convert tabs to spaces
--   fileencoding = "utf-8",                  -- the encoding written to a file
--   guifont = "monospace:h17",               -- the font used in graphical neovim applications
--   hlsearch = true,                         -- highlight all matches on previous search pattern
--   ignorecase = true,                       -- ignore case in search patterns
--   mouse = "a",                             -- allow the mouse to be used in neovim
--   number = true,                           -- set numbered lines
--   numberwidth = 4,                         -- set number column width to 2 {default 4}
--   pumheight = 10,                          -- pop up menu height
--   relativenumber = false,                  -- set relative numbered lines
--   scrolloff = 8,                           -- is one of my fav
--   shiftwidth = 2,                          -- the number of spaces inserted for each indentation
--   showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
--   showtabline = 2,                         -- always show tabs
--   sidescrolloff = 8,
--   signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
--   smartcase = true,                        -- smart case
--   smartindent = true,                      -- make indenting smarter again
--   splitbelow = true,                       -- force all horizontal splits to go below current window
--   splitright = true,                       -- force all vertical splits to go to the right of current window
--   swapfile = false,                        -- creates a swapfile
--   tabstop = 2,                             -- insert 2 spaces for a tab
--   timeoutlen = 1000,                        -- time to wait for a mapped sequence to complete (in milliseconds)
--   undofile = true,                         -- enable persistent undo
--   updatetime = 300,                        -- faster completion (4000ms default)
--   wrap = false,                            -- display lines as one long line
--   writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
-- }

for k, v in pairs(options) do
  vim.opt[k] = v
end
