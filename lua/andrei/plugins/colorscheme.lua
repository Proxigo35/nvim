return {
	"phha/zenburn.nvim",
	priority = 1000,
	config = function()
		require("zenburn").setup()
		vim.cmd("colorscheme zenburn")
		vim.api.nvim_set_hl(
				0,
				"Normal",
				{bg = "#000000"}
		)
		vim.api.nvim_set_hl(
				0,
				"NormalFloat",
				{bg = "#000000"}
		)
	end
}
