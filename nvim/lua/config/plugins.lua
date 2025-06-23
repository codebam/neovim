require("lualine").setup()

require("nvim-treesitter.configs").setup({
	auto_install = false,
	ignore_install = {},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,

			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",

				["as"] = "@statement.outer",
				["is"] = "@statement.inner",

				["al"] = "@loop.outer",
				["il"] = "@loop.inner",

				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",

				["a="] = "@assignment.outer",
				["i="] = "@assignment.inner",
				["alhs"] = "@assignment.lhs",
				["arhs"] = "@assignment.rhs",
			},
			include_surrounding_whitespace = true,
		},

		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
				["]a"] = "@parameter.inner",
				["]s"] = "@statement.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
				["]A"] = "@parameter.inner",
				["]S"] = "@statement.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
				["[a"] = "@parameter.inner",
				["[s"] = "@statement.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
				["[A"] = "@parameter.inner",
				["[S"] = "@statement.outer",
			},
			goto_next_start = {
				["]m"] = "@comment.outer",
			},
		},

		swap = {
			enable = true,
			swap_next = {
				["<leader>na"] = "@parameter.inner",
				["<leader>nf"] = "@function.outer",
			},
			swap_previous = {
				["<leader>pa"] = "@parameter.inner",
				["<leader>pf"] = "@function.outer",
			},
		},
		lsp_interop = {
			enable = true,
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},
	},
})

require("oil").setup()

require("gitsigns").setup()

vim.api.nvim_create_autocmd("User", {
	pattern = "BlinkCmpMenuOpen",
	callback = function()
		vim.b.copilot_suggestion_hidden = true
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "BlinkCmpMenuClose",
	callback = function()
		vim.b.copilot_suggestion_hidden = false
	end,
})

require("bqf").setup()
