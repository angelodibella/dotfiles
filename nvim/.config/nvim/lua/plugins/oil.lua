local permission_hlgroups = {
	["-"] = "NonText",
	["r"] = "DiagnosticSignWarn",
	["w"] = "DiagnosticSignError",
	["x"] = "DiagnosticSignOk",
}

function _G.get_oil_winbar()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local dir = require("oil").get_current_dir(bufnr)
	if dir then
		return vim.fn.fnamemodify(dir, ":~")
	else
		-- If there is no current directory (e.g. over ssh), just show the buffer name
		return vim.api.nvim_buf_get_name(0)
	end
end

return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			columns = {
				{
					"permissions",
					highlight = function(permission_str)
						local hls = {}
						for i = 1, #permission_str do
							local char = permission_str:sub(i, i)
							table.insert(hls, { permission_hlgroups[char], i - 1, i })
						end
						return hls
					end,
				},
				{ "size", highlight = "Special" },
				{
					"icon",
					default_file = icon_file,
					directory = icon_dir,
					add_padding = false,
				},
			},
			view_options = {
				show_hidden = true,
				natural_order = true,
				is_always_hidden = function(name, _)
					return name == ".." or name == ".git"
				end,
			},
			float = {
				padding = 2,
				max_width = 160,
				max_height = 0,
			},
			win_options = {
				wrap = true,
				winbar = "%!v:lua.get_oil_winbar()",
				winblend = 0,
			},
			preview_win = {
				-- Whether the preview window is automatically updated when the cursor is moved
				update_on_cursor_moved = true,
				-- How to open the preview window "load"|"scratch"|"fast_scratch"
				preview_method = "fast_scratch",
				-- Window-local options to use for preview window buffers
				win_options = {
					wrap = false,
					winbar = " ",
					winblend = 0,
				},
			},
			keymaps = {
				["<C-c>"] = false,
				["q"] = "actions.close",
			},
		})
	end,
}
