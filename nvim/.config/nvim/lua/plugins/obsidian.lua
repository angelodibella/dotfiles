return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/personal/*.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/Obsidian/personal/*.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"Saghen/blink.cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
		"OXY2DEV/markview.nvim",
	},
	---@module 'obsidian'
	---@type obsidian.config.ClientOpts
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Obsidian/personal",
			},
		},

		notes_subdir = "inbox",
		new_notes_location = "notes_subdir",

		completion = {
			blink = true,
			min_chars = 2,
		},

		mappings = {},

		templates = {
			folder = "templates",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
		},

		ui = {
			enable = true,
		},
	},
}
