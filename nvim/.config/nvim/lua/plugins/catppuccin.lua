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
					FloatBorder = { fg = colors.overlay0 },
				}
			end,
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
