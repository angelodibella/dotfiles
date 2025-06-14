return {
	"brianhuster/live-preview.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>ps", "<CMD>LivePreview start<CR>", { desc = "[p]review [s]tart" })
		vim.keymap.set("n", "<leader>pc", "<CMD>LivePreview close<CR>", { desc = "[p]review [c]lose" })
	end,
}
