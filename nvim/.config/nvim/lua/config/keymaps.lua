local map = vim.keymap.set

-- Set leader keys (ensure this is loaded before plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------------------------------------------------
-- [B] BUFFERS (Manage open files)
-----------------------------------------------------------
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete Buffer" })              -- Close buffer, not Neovim
map("n", "<leader>bX", "<cmd>%bd|e#|bd#<CR>", { desc = "Close All Other Buffers" }) -- Keep current, close rest

-----------------------------------------------------------
-- [W] WINDOWS (Manage splits)
-----------------------------------------------------------
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split Vertical" })
map("n", "<leader>ws", "<cmd>split<CR>", { desc = "Split Horizontal" })
map("n", "<leader>wc", "<cmd>close<CR>", { desc = "Close Window" })
map("n", "<leader>w=", "<C-w>=", { desc = "Equalize Windows" }) -- Reset split sizes

-----------------------------------------------------------
-- [Q] QUIT & SYSTEM
-----------------------------------------------------------
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit All" })
map("n", "<leader>qw", "<cmd>wq<CR>", { desc = "Save and Quit" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Quick Save" })

-----------------------------------------------------------
-- QUALITY OF LIFE
-----------------------------------------------------------
-- Clear search highlight on ESC
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear Highlight" })
-- Move highlighted text up/down in Visual mode (Alt + j/k)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move text up" })
-- Clipboard
map("v", "<C-c>", '"+y')
map("i", "<C-v>", '"+p')
