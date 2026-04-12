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
