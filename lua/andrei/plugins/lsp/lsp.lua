return {
	"hrsh7th/cmp-nvim-lsp",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	dependencies = {
		{
			"antosha417/nvim-lsp-file-operations",
			config = true,
		},
		{ "folke/lazydev.nvim" },
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local java_homes = {
			"/opt/homebrew/opt/openjdk",
			"/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home",
		}

		local function java_root_dir(bufnr, on_dir)
			local path = vim.api.nvim_buf_get_name(bufnr)
			local root = vim.fs.root(path, { "pom.xml", "build.gradle", "build.gradle.kts" })
				or vim.fs.root(path, { "settings.gradle", "settings.gradle.kts", "mvnw", "gradlew" })
				or vim.fs.root(path, ".git")

			if root then
				on_dir(root)
			end
		end

		if not vim.env.JAVA_HOME then
			for _, java_home in ipairs(java_homes) do
				if vim.fn.executable(java_home .. "/bin/java") == 1 then
					vim.env.JAVA_HOME = java_home
					break
				end
			end
		end

		vim.lsp.config("*", {
			capabilities = cmp_nvim_lsp.default_capabilities(),
		})

		vim.lsp.config("jdtls", {
			root_dir = java_root_dir,
			settings = {
				["java.import.gradle.enabled"] = false,
				["java.import.maven.enabled"] = true,
				["java.import.generatesMetadataFilesAtProjectRoot"] = false,
				["java.project.importOnFirstTimeStartup"] = "automatic",
			},
			init_options = {
				settings = {
					["java.import.gradle.enabled"] = false,
					["java.import.maven.enabled"] = true,
					["java.import.generatesMetadataFilesAtProjectRoot"] = false,
					["java.project.importOnFirstTimeStartup"] = "automatic",
				},
			},
			cmd = function(dispatchers, config)
				local cache_dir = vim.fn.stdpath("cache") .. "/jdtls"
				local workspace_dir = cache_dir .. "/workspace"
				local root_dir = config.root_dir or vim.fn.getcwd()
				local project_name = root_dir:gsub("/$", ""):match("([^/]+)$") or "workspace"
				local config_dir = cache_dir .. "/config/" .. project_name
				local jdtls = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
				local cmd = {
					vim.fn.executable(jdtls) == 1 and jdtls or "jdtls",
					"-configuration",
					config_dir,
					"-data",
					workspace_dir .. "/" .. project_name,
				}

				if vim.env.JAVA_HOME and vim.fn.executable(vim.env.JAVA_HOME .. "/bin/java") == 1 then
					table.insert(cmd, 2, "--java-executable")
					table.insert(cmd, 3, vim.env.JAVA_HOME .. "/bin/java")
				end

				vim.fn.mkdir(config_dir, "p")
				vim.fn.mkdir(workspace_dir, "p")

				return vim.lsp.rpc.start(cmd, dispatchers, {
					cwd = config.cmd_cwd,
					env = config.cmd_env,
					detached = config.detached,
				})
			end,
		})

		vim.diagnostic.config({
			virtual_text = { source = "if_many" },
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99

		local lsp_augroup = vim.api.nvim_create_augroup("andrei-lsp", { clear = true })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = lsp_augroup,
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local bufnr = event.buf

				local function map(keys, command, description)
					vim.keymap.set("n", keys, command, { buffer = bufnr, desc = "LSP: " .. description })
				end

				map("K", vim.lsp.buf.hover, "Hover documentation")
				map("gd", vim.lsp.buf.definition, "Go to definition")
				map("gD", vim.lsp.buf.declaration, "Go to declaration")
				map("gi", vim.lsp.buf.implementation, "Go to implementation")
				map("gr", vim.lsp.buf.references, "Go to references")
				map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
				map("<leader>ca", vim.lsp.buf.code_action, "Code action")
				map("<leader>D", vim.lsp.buf.type_definition, "Go to type definition")

				if client and client:supports_method("textDocument/foldingRange") then
					for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
						vim.wo[win][0].foldmethod = "expr"
						vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
						vim.wo[win][0].foldtext = "v:lua.vim.lsp.foldtext()"
					end
				end
			end,
		})
	end,
}
