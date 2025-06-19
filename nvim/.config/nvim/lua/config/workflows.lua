--- Obsidian Review Workflow ---

local function open_inbox_notes()
	local inbox_path = vim.fn.expand("~/Obsidian/personal/inbox")
	local inbox_files = vim.fn.glob(inbox_path .. "/*.md", true, true)

	if #inbox_files == 0 then
		print("Inbox is empty.")
		return
	end

	print("Starting inbox review session...")

	-- Replace the current buffer with the first inbox file.
	vim.cmd("edit " .. vim.fn.fnameescape(inbox_files[1]))

	-- Open the rest of the files in new tabs.
	if #inbox_files > 1 then
		for i = 2, #inbox_files do
			vim.cmd("tabedit " .. vim.fn.fnameescape(inbox_files[i]))
		end
	end

	-- Go back to the first tab to start the review.
	vim.cmd("tabfirst")
	print("Inbox review session started.")
end

local function trash_current_note()
	local current_file = vim.api.nvim_buf_get_name(0)
	if current_file == "" then
		print("Error: No file associated with this buffer.")
		return
	end

	local trash_dir = vim.fn.expand("~/.local/share/Trash/files")
	vim.fn.mkdir(trash_dir, "p")

	local file_name = vim.fn.fnamemodify(current_file, ":t")
	local new_path = trash_dir .. "/" .. file_name

	if os.rename(current_file, new_path) then
		print("Moved '" .. file_name .. "' to system trash.")
		vim.cmd("bdelete!")
	else
		print("Error: Failed to move file to trash.")
	end
end

local function get_tags_from_file(file_path)
	local tags = {}
	local lines = vim.fn.readfile(file_path)

	if not lines or #lines < 2 or lines[1] ~= "---" then
		return tags
	end

	local in_tags_section = false
	for i = 2, #lines do
		local line = lines[i]
		if line == "---" then
			break
		end
		if line:match("^%s*tags:%s*$") then
			in_tags_section = true
		elseif in_tags_section and line:match("^%s*-%s+.*") then
			local tag =
				line:match("^%s*-%s+(.*)"):gsub("^['\"]", ""):gsub("['\"]$", ""):gsub("^%s+", ""):gsub("%s+$", "")
			table.insert(tags, tag)
		elseif in_tags_section and line:match("^%S") then
			in_tags_section = false
		end
	end
	return tags
end

local function archive_inbox_note()
	local file_path = vim.api.nvim_buf_get_name(0)
	if not string.find(file_path, vim.fn.expand("~/Obsidian/personal/inbox/")) then
		print("Error: Note is not in the inbox.")
		return
	end

	local tags = get_tags_from_file(file_path)
	local target_dir_name = "topics"

	if vim.tbl_contains(tags, "guide") then
		target_dir_name = "guides"
	elseif vim.tbl_contains(tags, "snippet") then
		target_dir_name = "snippets"
	elseif vim.tbl_contains(tags, "fact") then
		target_dir_name = "facts"
	end

	local vault_path = vim.fn.expand("~/Obsidian/personal")
	local file_name = vim.fn.fnamemodify(file_path, ":t")
	local new_dir_path = vault_path .. "/" .. target_dir_name
	local new_file_path = new_dir_path .. "/" .. file_name

	vim.fn.mkdir(new_dir_path, "p")

	if os.rename(file_path, new_file_path) then
		print("Note archived to '" .. target_dir_name .. "'.")
		vim.cmd("bdelete!")
	else
		print("Error: Failed to archive note.")
	end
end

vim.keymap.set("n", "<leader>or", open_inbox_notes, { desc = "[r]eview notes in inbox" })
vim.keymap.set("n", "<leader>od", trash_current_note, { desc = "[d]elete note in buffer" })
vim.keymap.set("n", "<leader>oa", archive_inbox_note, { desc = "[a]rchive note in buffer" })
