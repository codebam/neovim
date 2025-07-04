vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 4

vim.lsp.inlay_hint.enable(true)

vim.lsp.enable("nixd")
vim.lsp.enable("nil_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("ts_ls")
vim.lsp.enable("cssls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("html")
vim.lsp.enable("svelte")
vim.lsp.enable("pyright")
vim.lsp.enable("dockerls")
vim.lsp.enable("bashls")
vim.lsp.enable("clangd")
vim.lsp.enable("jdtls")
vim.lsp.enable("csharp_ls")
vim.lsp.enable("markdown_oxide")
