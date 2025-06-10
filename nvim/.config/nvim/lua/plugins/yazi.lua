return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>yf",
			"<cmd>Yazi<cr>",
			desc = "open [y]azi at the current [f]ile",
		},
		{
			"<leader>yd",
			"<cmd>Yazi cwd<cr>",
			desc = "open [y]azi in the current working [d]irectory",
		},
	},
	opts = {
		open_for_directories = true,
	},
	init = function()
		vim.g.loaded_netrwPlugin = 1
	end,
}
