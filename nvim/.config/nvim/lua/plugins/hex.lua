return {
	"RaafatTurki/hex.nvim",
	cmd = { "HexToggle", "HexDump", "HexAssemble" },
	opts = {
		dump_cmd = "xxd -g 1 -u",
		assemble_cmd = "xxd -r",
	},
}
