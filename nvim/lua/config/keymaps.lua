vim.g.mapleader = "\\"

vim.keymap.set("n", "<leader><space>", ":nohl<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>xo", "<cmd>cwindow<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>xd", function()
	vim.diagnostic.setqflist()
end)
vim.keymap.set("n", "<leader>xr", vim.lsp.buf.references)
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>qD", function()
	vim.diagnostic.setqflist({ all = true })
end)
