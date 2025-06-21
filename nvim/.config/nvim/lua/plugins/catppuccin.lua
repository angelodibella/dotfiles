return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		compile = {
			enabled = true,
			path = vim.fn.stdpath("cache") .. "/catppuccin",
		},

		flavor = "mocha",
	},
	config = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
