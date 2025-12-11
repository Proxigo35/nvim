return {
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason").setup()
		end,
		opts = {
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"eslint",
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				"neovim/nvim-lspconfig",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"eslint_d",
				"isort", -- python formatter
				"black", -- python formatter
				"pylint",
			},
		},
		dependencies = { "williamboman/mason.nvim" },
	},
}
