return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
		{
			"<leader>fd",
			function()
				require("telescope.builtin").diagnostics()
			end,
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
		},
	},
}
