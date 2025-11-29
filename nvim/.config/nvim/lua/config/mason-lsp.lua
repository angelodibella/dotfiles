return {
	-- Bash and Zsh
	bashls = {},

	-- C++
	clangd = {
		init_options = {
			fallbackFlags = { "--std=c++23" },
		},
	},

	-- LaTeX
	latexindent = {},
	vale = {},

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

	-- Meson
	mesonlsp = {},

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

	-- TOML
	taplo = {},
}
