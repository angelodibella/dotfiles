return {
	"lervag/vimtex",
	lazy = false, -- vimtex installs its own ftdetect; don't lazy-load
	init = function()
		-- D-Bus-enabled zathura gives us bidirectional SyncTeX:
		--   forward:  <localleader>lv  (:VimtexView → jump PDF to cursor)
		--   reverse:  <Ctrl>+click in the PDF → jumps nvim to the source line
		-- `zathura_simple` (the previous value) was the stripped-down variant
		-- that disables D-Bus and therefore breaks both directions.
		vim.g.vimtex_view_method = "zathura"

		-- latexmk is the default; being explicit makes the config self-documenting.
		-- It already passes -synctex=1, so no extra flags needed for SyncTeX.
		vim.g.vimtex_compiler_method = "latexmk"

		-- Don't pop the quickfix window on warnings/errors. `<localleader>le`
		-- opens it on demand.
		vim.g.vimtex_quickfix_mode = 0

		-- Faster than automatic folds on large documents; use zM/zR to fold/unfold.
		vim.g.vimtex_fold_manual = 1
	end,
}
