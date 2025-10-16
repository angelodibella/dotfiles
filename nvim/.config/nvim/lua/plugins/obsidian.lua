return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	lazy = true,
	-- event = {
	-- 	"BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/personal/*.md",
	-- 	"BufNewFile " .. vim.fn.expand("~") .. "/Obsidian/personal/*.md",
	-- },
	event = "VimEnter", -- to access notes from anywhere
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
		-- No legacy commands warning
		legacy_commands = false,

		workspaces = {
			{
				name = "personal",
				path = "~/Obsidian/personal",
			},
		},

		notes_subdir = "inbox",
		new_notes_location = "notes_subdir",

		note_id_func = function(title)
			return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		end,

		preferred_link_style = "wiki",

		picker = {
			name = "telescope.nvim",
			note_mappings = {
				-- Create a new note from your query
				new = "<C-x>",
				-- Insert a link to the selected note
				insert_link = "<C-l>",
			},
			tag_mappings = {
				-- Add tag(s) to current note
				tag_note = "<C-x>",
				-- Insert a tag at the current location
				insert_tag = "<C-l>",
			},
		},

		-- backlinks = {
		-- 	parse_headers = true,
		-- },

		completion = {
			blink = true,
			min_chars = 2,
		},

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
