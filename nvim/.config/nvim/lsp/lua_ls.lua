---@type vim.lsp.Config
return {
	settings = {
		Lua = {
			completion = { callSnippet = "Replace" },
			-- lazydev.nvim provides the real lua runtime/plugin types; this just
			-- silences the confusing "undefined global `vim`" diagnostic.
			diagnostics = { globals = { "vim" } },
		},
	},
}
