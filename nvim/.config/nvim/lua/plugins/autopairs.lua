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
		-- InsertEnter (not InsertCharPre) so tabout is loaded and its Tab
		-- mapping is installed before the user's first keystroke — otherwise
		-- the very first Tab in a fresh insert session is missed.
		event = "InsertEnter",
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
				{ open = "$", close = "$" }, -- LaTeX inline math
			},
			ignore_beginning = true,
			-- tex is handled by blink.cmp's own <Tab> chain (see
			-- lua/plugins/blink.lua). Excluding it here prevents tabout's
			-- treesitter walk-to-parent logic from teleporting the cursor
			-- past `\end{document}` when Tab is pressed outside a pair.
			exclude = { "tex" },
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
