local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

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
keymap.set("n", "<C-k>", ":resize +2<CR>", opts)
keymap.set("n", "<C-j>", ":resize -2<CR>", opts)
keymap.set("n", "<C-h>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers - S stand for Shift
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

keymap.set("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Open current file in a new tab
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
keymap.set("n", "<Leader>nh", ":nohl<CR>", opts)
