return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	ft = "rust", -- load only for Rust buffers
	lazy = true, -- important: don't run at startup
	config = function()
		local cfg = require("rustaceanvim.config")

		local codelldb = vim.fn.exepath("codelldb")
		if codelldb == "" then
			-- codelldb isn't installed (or not on PATH); avoid crashing Neovim startup
			return
		end

		local sys = vim.loop.os_uname().sysname
		local ext = (sys == "Linux") and ".so" or (sys == "Darwin") and ".dylib" or ".dll"
		local liblldb = vim.fn.expand("$MASON/opt/lldb/lib/liblldb" .. ext)

		vim.g.rustaceanvim = {
			dap = {
				adapter = cfg.get_codelldb_adapter(codelldb, liblldb),
			},
		}
	end,
}
