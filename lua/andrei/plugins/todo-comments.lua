return {
	"folke/todo-comments.nvim",
	event = {
		"BufReadPre",
		"BufNewFile"
	},
	dependencies = {"nvim-lua/plenary.nvim"},
	config = function()
		local todo_comments = require("todo-comments")
		local keymap = vim.keymap

		keymap.set(
			"n", "]t", function()
				todo_comments.jump_next()
			end,
			{desc = "Next todo comment"}
		)

		keymap.set(
			"n", "[t", function()
				todo_comments.jump_prev()
			end,
			{desc = "Previous todo comment"}
		)

		local rg = vim.fn.exepath("rg")

		if rg == "" then
			for _, path in ipairs(
				{
					"/opt/homebrew/bin/rg",
					"/usr/local/bin/rg",
					"/Applications/Codex.app/Contents/Resources/rg"
				}
			) do
				if vim.fn.executable(path) == 1 then
					rg = path
					break
				end
			end
		end

		todo_comments.setup(
			{
				highlight = {
					pattern = [[.*<((KEYWORDS)(-\d+)?)\s*:]]
				},
				search = {
					command = rg ~= "" and rg or "rg",
					pattern = [[\b(KEYWORDS)(-\d+)?:]]
				}
			}
		)
	end
}
