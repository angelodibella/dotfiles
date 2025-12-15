return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	ft = { "rust" },
	config = function()
		local ra_path = vim.fn.trim(vim.fn.system("rustup which rust-analyzer"))

		local mason_path = vim.fn.stdpath("data") .. "/mason"
		local codelldb_root = mason_path .. "/packages/codelldb"
		local codelldb_path = codelldb_root .. "/extension/adapter/codelldb"

		local sys = vim.loop.os_uname().sysname
		local ext = (sys == "Linux") and ".so" or (sys == "Darwin") and ".dylib" or ".dll"
		local liblldb_path = codelldb_root .. "/extension/lldb/lib/liblldb" .. ext

		vim.g.rustaceanvim = {
			server = {
				cmd = { ra_path },
				default_settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			},

			dap = {
				adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
			},
		}
	end,
}
