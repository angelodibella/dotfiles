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
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" })

--- Plugin Keymaps ---

-- Git
vim.keymap.set("n", "<leader>gs", "<CMD>Git<CR>", { desc = "[g]it [s]tatus" })
vim.keymap.set("n", "<leader>gc", "<CMD>Git commit<CR>", { desc = "[g]it [c]ommit" })
vim.keymap.set("n", "<leader>gp", "<CMD>Git pull<CR>", { desc = "[g]it [p]ull" })
vim.keymap.set("n", "<leader>gP", "<CMD>Git push<CR>", { desc = "[g]it [P]ush" })
vim.keymap.set("n", "<leader>gd", "<CMD>Gvdiffsplit<CR>", { desc = "[g]it [d]iff" })
vim.keymap.set("n", "<leader>gw", "<CMD>Gwrite<CR>", { desc = "[g]it [w]rite" })
vim.keymap.set("n", "<leader>gr", "<CMD>G restore --staged %<CR>", { desc = "[g]it [r]estore staged" })
vim.keymap.set("n", "<leader>gR", "<CMD>Gread<CR>", { desc = "[g]it [R]ead" })
vim.keymap.set("n", "<leader>gl", "<CMD>Gllog<CR>", { desc = "[g]it [l]og" })

-- Hex
vim.keymap.set("n", "<leader>tx", "<CMD>HexToggle<CR>", { desc = "[t]oggle he[x] representation" })

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
vim.keymap.set("n", "-", "<CMD>Oil --float --preview<CR>", { desc = "open parent directory" })

-- Refactoring
-- vim.keymap.set("x", "<leader>re", ":Refactor extract ")
-- vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
-- vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
-- vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
-- vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")
-- vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
-- vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- Remote SSHFS
vim.keymap.set("n", "<leader>rc", "<CMD>RemoteSSHFSConnect<CR>", { desc = "[c]onnect to remote" })
vim.keymap.set("n", "<leader>rd", "<CMD>RemoteSSHFSDisconnect<CR>", { desc = "[d]isconnect from remote" })
vim.keymap.set("n", "<leader>re", "<CMD>RemoteSSHFSEdit<CR>", { desc = "[e]dit SSH config files" })
