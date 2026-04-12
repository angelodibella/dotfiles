---@type vim.lsp.Config
return {
	settings = {
		basedpyright = {
			disableOrganizeImports = true, -- ruff handles imports
		},
		python = {
			analysis = {
				ignore = { "*" }, -- ruff handles diagnostics
			},
		},
	},
}
