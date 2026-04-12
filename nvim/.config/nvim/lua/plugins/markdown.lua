return {
	{
		"brianhuster/live-preview.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		cmd = { "LivePreview" },
		keys = {
			{ "<leader>ps", "<CMD>LivePreview start<CR>", desc = "[p]review [s]tart" },
			{ "<leader>pc", "<CMD>LivePreview close<CR>", desc = "[p]review [c]lose" },
		},
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		dependencies = { "saghen/blink.cmp" },
		opts = {},
	},
}
