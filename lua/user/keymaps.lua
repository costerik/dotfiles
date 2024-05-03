local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- keymap("n", "<leader>e", ":Lex 30<cr>", opts) -- Replaced in favor of NvimTree

-- Resize with arrows - C stand for Control
opts.desc = "Resize Horizontal Split Down"
keymap.set("n", "<C-k>", ":resize +2<CR>", opts)

opts.desc = "Resize Horizontal Split Up"
keymap.set("n", "<C-j>", ":resize -2<CR>", opts)

opts.desc = "Resize Vertical Split Down"
keymap.set("n", "<C-h>", ":vertical resize -2<CR>", opts)

opts.desc = "Resize Vertical Split Up"
keymap.set("n", "<C-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers - S stand for Shift
opts.desc = "Navigate to the Next Buffer"
keymap.set("n", "<S-l>", ":bnext<CR>", opts)

opts.desc = "Navigate to the Previous Buffer"
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
opts.desc = "Move Selected Code to the Left"
keymap.set("v", "<", "<gv", opts)

opts.desc = "Move Selected Code to the Right"
keymap.set("v", ">", ">gv", opts)

keymap.set("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
opts.desc = "Move Selected Code Up"
keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)

opts.desc = "Move Selected Code Down"
keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)

-- Open current file in a new tab
opts.desc = "Open Current buffer in a new tab"
keymap.set("n", "<C-w>T", ":tab split<CR>", opts)

-- Delete without yanking to the default register
keymap.set("n", "d", '"_d', opts)
keymap.set("v", "d", '"_d', opts)

-- copy to system clipboard
keymap.set("x", "<Leader>y", '"*y', opts)
keymap.set("x", "<Leader>p", '"*p', opts)
keymap.set("x", "<Leader>Y", '"+y', opts)
keymap.set("x", "<Leader>P", '"*p', opts)

-- Clear current search highlight
opts.desc = "Remove highlighted text"
keymap.set("n", "<Leader>nh", ":nohl<CR>", opts)
