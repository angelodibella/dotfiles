return {
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
		-- Snippet Engine
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
			opts = {},
		},
		"folke/lazydev.nvim",
	},
	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		keymap = {
			-- All presets have the following mappings:
			-- <c-y> to accept ([y]es) the completion.
			-- <tab>/<s-tab>: move to right/left of your snippet expansion
			-- <c-space>: Open menu or open docs if already open
			-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
			-- <c-b>/<c-f>: Scroll documentation up/down
			-- <c-e>: Hide menu
			-- <c-k>: Toggle signature help
			preset = "default",

			-- LaTeX's tree-sitter grammar doesn't wrap `(…)`, `[…]`, `{…}` in
			-- document-body text as a named pair node, so tabout.nvim's
			-- treesitter-based jump misses them. Slot a balanced-pair
			-- scanner into blink.cmp's Tab chain for tex buffers.
			--
			-- Algorithm: walk backward on the current line tracking depth
			-- to find the innermost unmatched opener; then walk forward
			-- to its matching closer. For `$`, which is self-matching, use
			-- parity (odd number of `$` before cursor ⇒ inside math).
			-- Returns true only when genuinely enclosed, so pressing Tab
			-- outside a pair falls through cleanly to literal Tab — no
			-- surprise jumps to the end of the enclosing environment.
			--
			-- Order: snippet_forward → tex balanced-pair jump → fallback.
			["<Tab>"] = {
				"snippet_forward",
				function()
					if vim.bo.filetype ~= "tex" then
						return
					end
					local row, col = unpack(vim.api.nvim_win_get_cursor(0))
					local line = vim.api.nvim_get_current_line()
					local pair_of = { ["("] = ")", ["["] = "]", ["{"] = "}" }
					local open_of = {}
					for o, c in pairs(pair_of) do
						open_of[c] = o
					end

					-- Find the innermost unmatched `(` / `[` / `{` opener
					-- to the left of the cursor.
					local unmatched = { ["("] = 0, ["["] = 0, ["{"] = 0 }
					local opener
					for i = col, 1, -1 do
						local ch = line:sub(i, i)
						if open_of[ch] then
							unmatched[open_of[ch]] = unmatched[open_of[ch]] + 1
						elseif pair_of[ch] then
							if unmatched[ch] > 0 then
								unmatched[ch] = unmatched[ch] - 1
							else
								opener = ch
								break
							end
						end
					end

					-- Fall back to `$` parity if no bracket opener was found.
					if not opener then
						local dollars = 0
						for i = 1, col do
							if line:sub(i, i) == "$" then
								dollars = dollars + 1
							end
						end
						if dollars % 2 == 1 then
							opener = "$"
						end
					end

					if not opener then
						return
					end

					-- Walk forward to the matching closer, honouring nesting
					-- for asymmetric pairs.
					local closer = opener == "$" and "$" or pair_of[opener]
					local depth = 1
					for i = col + 1, #line do
						local ch = line:sub(i, i)
						if opener ~= "$" and ch == opener then
							depth = depth + 1
						elseif ch == closer then
							depth = depth - 1
							if depth == 0 then
								vim.api.nvim_win_set_cursor(0, { row, i })
								return true
							end
						end
					end
				end,
				"fallback",
			},
		},

		appearance = {
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		completion = {
			ghost_text = { enabled = true },
			list = { selection = { auto_insert = false } },
			documentation = { auto_show = true, treesitter_highlighting = true },

			-- Make it look like nvim-cmp
			-- menu = {
			-- 	draw = { columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } } },
			-- },

			menu = {
				draw = {
					padding = 0,
					columns = { { "kind_icon", gap = 1 }, { gap = 1, "label" }, { "kind", gap = 2 } },
					components = {
						kind_icon = {
							text = function(ctx)
								return " " .. ctx.kind_icon .. " "
							end,
							highlight = function(ctx)
								return "BlinkCmpKindIcon" .. ctx.kind
							end,
						},
						kind = {
							text = function(ctx)
								return " " .. ctx.kind .. " "
							end,
						},
					},
				},
			},
		},

		sources = {
			default = { "avante", "lsp", "path", "snippets", "lazydev" },
			providers = {
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
					opts = {
						-- options for blink-cmp-avante
					},
				},
			},
		},

		snippets = { preset = "luasnip" },

		-- Prefer blink.cmp's native Rust fuzzy matcher (auto-downloads a
		-- prebuilt binary), falling back to the Lua implementation with a
		-- warning if the binary isn't available.
		-- See :h blink-cmp-config-fuzzy for details.
		fuzzy = { implementation = "prefer_rust_with_warning" },

		-- Shows a signature help window while you type arguments for a function
		signature = { enabled = true },
	},
}
