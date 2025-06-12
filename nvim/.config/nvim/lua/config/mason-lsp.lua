-- Enable the following language servers.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
return {
	-- Bash and Zsh
	bashls = {},

	-- C++
	clangd = {},

	-- Lua
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	},

	-- Python
	basedpyright = {
		settings = {
			basedpyright = {
				-- Let Ruff do this
				disableOrganizeImports = true,
			},
			python = {
				analysis = {
					-- Use Ruff for linting
					ignore = { "*" },
				},
			},
		},
	},
	ruff = {}, -- Use for linting, formatting and import organization

	-- Rust
	rust_analyzer = {},
}
