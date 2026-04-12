-- Declarative list of LSP servers we want installed and enabled.
-- Per-server overrides live in `~/.config/nvim/lsp/<name>.lua` (Neovim 0.11+
-- runtime path); no file needed for servers we're happy with the defaults on.
-- `rust_analyzer` is intentionally absent: rustaceanvim owns its lifecycle.
local servers = {
	"clangd",
	"texlab",
	"lua_ls",
	"mesonlsp",
	"basedpyright",
	"ruff",
	"taplo",
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		-- mason-lspconfig is NOT setup() here (we don't need its automatic_enable
		-- behaviour — vim.lsp.enable is authoritative). It's still listed so
		-- lazy installs it, which lets mason-tool-installer's pcall require
		-- find the lspconfig→mason package name mappings.
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
	},
	config = function()
		-- Diagnostic UI
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = " ",
				},
			},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(d)
					return d.message
				end,
			},
		})

		-- LspAttach: keymaps, reference highlight, inlay hints
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				local builtin = require("telescope.builtin")

				map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
				map("gr", builtin.lsp_references, "[G]oto [R]eferences")
				map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- Highlight references under cursor
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "user-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- Toggle Inlay Hints
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- Install every LSP server + extra tool via mason-tool-installer.
		-- It maps lspconfig names (e.g. lua_ls) to mason packages (lua-language-server).
		local ensure_installed = vim.list_extend(vim.deepcopy(servers), require("config.mason-extra"))
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- Set defaults that apply to every server: blink.cmp capabilities merged
		-- on top of the built-in client capabilities. Per-server overrides live
		-- in `lsp/<name>.lua` and are merged automatically by Neovim.
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		-- Enable everything. Neovim reads nvim-lspconfig's `lsp/<name>.lua` from
		-- runtimepath for defaults, then our `lsp/<name>.lua` overrides, then the
		-- `*` defaults above. `vim.lsp.enable` also hooks FileType autocmds so
		-- servers attach lazily when a matching buffer opens.
		vim.lsp.enable(servers)
	end,
}
