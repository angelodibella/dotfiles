-- Enable other Mason features that are not LSPs. E.g., formatters, linters
-- and DAPs.
return {
	-- Bash and Zsh
	"shellcheck", -- linter (bash-only)
	"beautysh", -- formatter

	-- Lua
	"stylua",
}
