return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	opts = {
		{
			provider = "claude",
			providers = {
				ollama = {
					model = "qwen2.5-coder:32b",
				},
				gemini = {
					model = "gemini-2.5-flash-preview-05-20",
				},
				claude = {
					endpoint = "https://api.anthropic.com",
					model = "claude-sonnet-4-20250514",
					api_key_name = { "pass", "show", "anthropic-api-key" },
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
			behaviour = {
				auto_approve_tool_permissions = true,
			},
		},
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
		"muniftanjim/nui.nvim",
	},
}
