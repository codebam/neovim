return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	opts = {
		provider = "ollama",
		providers = {
			ollama = {
				model = "devstral:latest",
			},
			gemini = {
				model = "gemini-2.5-flash-preview-05-20",
			},
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-sonnet-4-20250514",
				api_key_name = "cmd:pass show anthropic-api-key",
			},
			rag_service = {
				__inherited_from = "ollama",
				enabled = true,
				host_mount = os.getenv("HOME"),
				runner = "nix",
				llm = {
					provider = "ollama",
					endpoint = "http://localhost:11434",
					api_key = "",
					model = "qwen3:14b",
				},
				embed = {
					provider = "ollama",
					endpoint = "http://localhost:11434",
					api_key = "",
					model = "nomic-embed-text:latest",
				},
			},
		},
		web_search_engine = {
			provider = "searxng",
			providers = {
				searxng = {
					api_url_name = "SEARXNG_API_URL",
					query = "?q=",
				},
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
