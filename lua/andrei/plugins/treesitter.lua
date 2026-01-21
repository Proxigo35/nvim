return {
	"nvim-treesitter/nvim-treesitter",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = { enable = true },
			indent = { enable = true },
			--autotag = { enable = true },
			ensure_installed = {
				"java",
				"sql",
				"json",
				"javascript",
				"typescript",
				"html",
				"css",
				"bash",
				"lua",
				"c",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})

		-- use bash parser for zsh files
		vim.treesitter.language.register("bash", "zsh")

		-- treat Angular component HTML as html
		vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
			pattern = "*.component.html",
			callback = function()
				vim.bo.filetype = "html"
			end,
		})

		vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
			pattern = "*.page.html",
			callback = function()
				vim.bo.filetype = "html"
			end,
		})

		-- treat Angular component HTML as html
		vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
			pattern = "*.component.ts",
			callback = function()
				vim.bo.filetype = "ts"
			end,
		})

		vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
			pattern = "*.page.ts",
			callback = function()
				vim.bo.filetype = "ts"
			end,
		})
	end,
}
