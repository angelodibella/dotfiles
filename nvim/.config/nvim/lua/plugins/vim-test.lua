return {
	"vim-test/vim-test",
	dependencies = { "preservim/vimux" },
	cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
	keys = {
		{ "<leader>Tn", "<CMD>TestNearest<CR>", desc = "[T]est [n]earest" },
		{ "<leader>Tf", "<CMD>TestFile<CR>", desc = "[T]est [f]ile" },
		{ "<leader>Ts", "<CMD>TestSuite<CR>", desc = "[T]est [s]uite" },
		{ "<leader>Tl", "<CMD>TestLast<CR>", desc = "[T]est [l]ast" },
		{ "<leader>Tv", "<CMD>TestVisit<CR>", desc = "[T]est [v]isit" },
	},
	init = function()
		vim.g["test#strategy"] = "vimux"
	end,
}
