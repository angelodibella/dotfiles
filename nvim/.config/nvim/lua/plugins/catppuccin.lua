return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
		highlight_overrides = {
			all = function(colors)
				return {
					CmpBorder = { fg = "#3e4145" },
				}
			end,
			mocha = function(mocha)
				return {
					Comment = { fg = mocha.flamingo },
				}
			end,
		},
	},
	config = function()
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
