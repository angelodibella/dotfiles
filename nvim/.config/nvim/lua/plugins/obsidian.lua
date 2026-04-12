return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	lazy = true,
	-- Load on VimEnter so the `Obsidian …` commands and the `gf` follow-link
	-- keymap are available from any buffer, not just notes in the vault.
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"saghen/blink.cmp",
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

		link = { style = "wiki" },

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
