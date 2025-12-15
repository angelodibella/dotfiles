return {
	-- bashls = {}, -- Optional: bashls is often redundant if you have shellcheck
	clangd = {
		init_options = { fallbackFlags = { "--std=c++23" } },
	},
	-- latexindent = {}, -- Not an LSP! Move to extras if you just need the tool installed.
	texlab = {}, -- Use texlab as the actual LaTeX LSP
	lua_ls = {
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
				diagnostics = { globals = { "vim" } }, -- Fix confusing "undefined global vim"
			},
		},
	},
	mesonlsp = {},
	basedpyright = {
		settings = {
			basedpyright = { disableOrganizeImports = true },
			python = { analysis = { ignore = { "*" } } },
		},
	},
	ruff = {},
	taplo = {},
}
