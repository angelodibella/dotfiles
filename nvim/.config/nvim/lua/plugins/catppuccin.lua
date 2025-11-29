return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			compile = {
				enabled = true,
				path = vim.fn.stdpath("cache") .. "/catppuccin",
			},

			custom_highlights = function(colors)
				return {
					-- FloatBorder = { fg = colors.overlay0 },

					TelescopeBorder = { fg = colors.text, bg = colors.mantle },
					--
					TelescopePromptNormal = { fg = colors.text, bg = colors.surface0 },
					TelescopePromptBorder = { fg = colors.text, bg = colors.surface0 },
					TelescopePromptTitle = { fg = colors.mantle, bg = colors.blue },
					-- TelescopePromptCounter = { fg = colors.gray, bg = colors.fg_gutter },
					--
					TelescopeResultsTitle = { fg = colors.mantle, bg = colors.none },
					--
					TelescopePreviewTitle = { fg = colors.mantle, bg = colors.green },
					--
					-- TelescopeMatching = { fg = colors.orange, style = "bold" },
					--
					-- TelescopeDirectoryCustom = { fg = colors.comment },
				}
			end,
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
