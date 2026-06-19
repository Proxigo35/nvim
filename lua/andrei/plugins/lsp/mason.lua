return {
	{
		"williamboman/mason-lspconfig.nvim",
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
				"clangd",
				"jdtls",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function(_, opts)
			require("mason").setup()
			require("mason-lspconfig").setup(opts)
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				--"prettier", -- prettier formatter
				--"stylua", -- lua formatter
				--"google-java-format",
				"stylua", -- lua formatter
				"google-java-format",
				--"eslint_d",
				--"isort", -- python formatter
				--"black", -- python formatter
				--"pylint",
			},
		},
		dependencies = { "williamboman/mason.nvim" },
	},
}
