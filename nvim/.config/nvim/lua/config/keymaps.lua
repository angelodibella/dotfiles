-- Move around windows
vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })

-- Clear highlights on search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostic [q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--- Plugin Keymaps ---

-- Markview
vim.keymap.set("n", "<leader>tm", "<CMD>Markview toggle<CR>", { desc = "[t]oggle [m]arkview rendering" })

-- Obsidian
vim.keymap.set("n", "gf", function()
	if require("obsidian").util.cursor_on_markdown_link() then
		return "<cmd>Obsidian follow_link<CR>"
	else
		return "gf"
	end
end, { noremap = false, expr = true })
vim.keymap.set("n", "<leader>ot", "<CMD>Obsidian new_from_template<CR>", { desc = "new note from [t]emplate" })
vim.keymap.set("n", "<leader>ob", "<CMD>Obsidian backlinks<CR>", { desc = "list [b]acklinks to the current note" })
vim.keymap.set("n", "<leader>ol", "<CMD>Obsidian links<CR>", { desc = "list [l]inks in the current note" })
vim.keymap.set("n", "<leader>of", "<CMD>Obsidian search<CR>", { desc = "[f]ind note" })

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "open parent directory" })

-- Remote SSHFS
vim.keymap.set("n", "<leader>rc", "<CMD>RemoteSSHFSConnect<CR>", { desc = "[c]onnect to remote" })
vim.keymap.set("n", "<leader>rd", "<CMD>RemoteSSHFSDisconnect<CR>", { desc = "[d]isconnect from remote" })
vim.keymap.set("n", "<leader>re", "<CMD>RemoteSSHFSEdit<CR>", { desc = "[e]dit SSH config files" })
