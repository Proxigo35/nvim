vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
keymap.set("t", "<C-\\>", "<C-\\><C-n><cmd>tabp<CR>", { desc = "Enter 'Normal mode' in terminal and go to previous tab" })
keymap.set("t", "<C-[>", "<C-\\><C-n><cmd>tabclose<CR>", { desc = "Close terminal tab from terminal mode" })
keymap.set("t", "<C-]>", "<C-\\><C-n>", { desc = "Enter normal mode in terminal" })
keymap.set("n", "<leader>ter", "<cmd>tabnew<CR><cmd>terminal<CR>i", { desc = "Open a terminal in a new tab" })
keymap.set("n", "<C-c>", "\"+y", { desc = "Copy to system clipboard" })
keymap.set("n", "<C-v>", "\"+p", { desc = "Paste to system clipboard" })
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>c", "<cmd>tabnew<CR><cmd>terminal<CR>iclear && g++ -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -pedantic-errors -std=c++23 *.cpp && ./a.out<enter>", { desc = "Compile *.cpp" })
