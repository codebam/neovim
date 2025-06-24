return {
	"l3mon4d3/luasnip",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"honza/vim-snippets",
	},
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
		require("luasnip").filetype_extend("all", { "_" })
		require("luasnip.loaders.from_snipmate").lazy_load()
		require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets" } })
	end,
}
