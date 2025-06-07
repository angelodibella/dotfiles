return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master", -- TODO: Change to main once stable.
	lazy = false,
	build = ":TSUpdate",
	opts = {
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	},
}
