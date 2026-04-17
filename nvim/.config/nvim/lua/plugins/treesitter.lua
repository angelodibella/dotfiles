-- Parsers we want available. Anything not in this list can still be installed
-- on demand via `:TSInstall <lang>`.
local ensure_installed = {
	"bash",
	"bibtex",
	"c",
	"cpp",
	"css",
	"diff",
	"dockerfile",
	"git_config",
	"gitcommit",
	"gitignore",
	"html",
	"json",
	"latex",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"rust",
	"toml",
	"vim",
	"vimdoc",
	"yaml",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- The `main` branch is the nvim 0.11+ rewrite; it relies on core Neovim
		-- treesitter APIs instead of registering legacy query predicates. The
		-- `master` branch breaks on nvim 0.12 because its `query_predicates.lua`
		-- tries to call `node:range()` on nil values returned by the new core
		-- query iterator (visible as a crash when opening markdown files).
		branch = "main",
		lazy = false,
		-- `:TSUpdate` is registered by the plugin's own `plugin/` file, which
		-- lazy.nvim loads fresh after the branch checkout. Using the command
		-- form (instead of `require('nvim-treesitter').update()`) avoids a
		-- stale-require-cache issue during the initial master→main switch.
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")

			-- Main branch compiles parsers locally via the `tree-sitter` CLI.
			-- Only attempt install when the CLI is actually available so we
			-- don't flood stderr on every startup when it's missing.
			if vim.fn.executable("tree-sitter") == 1 then
				local installed = {}
				for _, name in ipairs(ts.get_installed() or {}) do
					installed[name] = true
				end
				local missing = vim.tbl_filter(function(lang)
					return not installed[lang]
				end, ensure_installed)
				if #missing > 0 then
					ts.install(missing)
				end
			end

			-- Enable highlighting + indent on every matching buffer. On the main
			-- branch, `vim.treesitter.start()` is the public entry point — we
			-- attach it via a FileType autocmd the way the upstream README shows.
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
				callback = function(args)
					local buf = args.buf
					local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
					if not lang then
						return
					end
					-- pcall so buffers opened before the async install finishes
					-- don't raise; they'll pick up highlighting after :e.
					if not pcall(vim.treesitter.start, buf, lang) then
						return
					end
					-- Only swap in the TS indent expression when an `indents.scm`
					-- actually exists for this language; otherwise the expression
					-- returns -1 for every line and silently shadows filetype
					-- indent plugins (e.g. VimTeX's for .tex).
					if vim.treesitter.query.get(lang, "indents") then
						vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		-- treesitter-context uses core Neovim treesitter APIs directly, so it's
		-- unaffected by the master→main branch switch above.
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		opts = {
			multiwindow = false,
			max_lines = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = "outer",
			mode = "cursor",
			zindex = 20,
		},
	},
}
