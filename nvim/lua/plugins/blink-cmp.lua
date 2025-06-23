return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			signature = { enabled = true },
			snippets = { preset = "luasnip" },
			sources = {
				default = {
					"snippets",
					"lazydev",
					"lsp",
					"copilot",
					"path",
					"omni",
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
		},
		opts_extend = { "sources.default" },
		dependencies = {
			"l3mon4d3/luasnip",
		},
	},
	{
		"giuxtaposition/blink-cmp-copilot",
	},
}
