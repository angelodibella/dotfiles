return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			-- Auto-close (), {}, [], "", '', etc.
			map_bs = true,
			-- Make <CR> inside pairs split & indent:
			--   (|) + Enter -> (
			--                    |
			--                  )
			map_cr = true,
			-- Don't skip adding a close-pair when one already exists ahead on the line.
			enable_check_bracket_line = false,
			-- Use Treesitter to avoid pairing inside strings/comments where it would be wrong.
			check_ts = true,
			disable_filetype = { "TelescopePrompt" },
		},
	},
	{
		"abecodes/tabout.nvim",
		event = "InsertCharPre",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
		},
		opts = {
			tabkey = "<Tab>",
			backwards_tabkey = "<S-Tab>",
			act_as_tab = true,
			act_as_shift_tab = false,
			default_tab = "<C-t>",
			default_shift_tab = "<C-d>",
			enable_backwards = true,
			completion = false,
			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
				{ open = "{", close = "}" },
			},
			ignore_beginning = true,
			exclude = {},
		},
	},
	{
		-- Free up <Tab>/<S-Tab> so tabout.nvim can own them.
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},
}
