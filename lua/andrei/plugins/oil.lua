return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
		{ "<leader>eo", "<cmd>Oil<CR>", desc = "Open Oil" },
		{ "<leader>eO", "<cmd>Oil --float<CR>", desc = "Open Oil floating" },
	},
	opts = {
		default_file_explorer = false,
		columns = {
			"icon",
		},
		view_options = {
			show_hidden = true,
		},
	},
}
