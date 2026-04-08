return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	opts = {
		provider = "openai_compatible",
		providers = {
			openai_compatible = {
				__inherited_from = "openai",
				api_key_name = "",
				endpoint = "http://localhost:8000/v1",
				model = "google/gemma-4-E4B-it",
			},
		},
		behaviour = {
			auto_approve_tool_permissions = true,
		},
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
		"muniftanjim/nui.nvim",
	},
}
