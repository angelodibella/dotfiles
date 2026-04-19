return {
	"kylechui/nvim-surround",
	version = "*",
	-- keys trigger lazy-load; listing them is cheaper than event = "VeryLazy".
	keys = {
		{ "ys", mode = "n", desc = "add surround" },
		{ "yss", mode = "n", desc = "add surround to line" },
		{ "ds", mode = "n", desc = "delete surround" },
		{ "cs", mode = "n", desc = "change surround" },
		{ "S", mode = "x", desc = "surround selection" },
	},
	opts = {},
}
