return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
			ensure_installed = { "lua_ls", "ts_ls", "eslint", "emmet_ls", "cssls", "tailwindcss", "omnisharp" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			})
			lspconfig.eslint.setup({
				capabilities = capabilities,
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
				settings = {
					workingDirectory = { mode = "auto" },
				},
			})
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
				filetypes = { "css", "scss", "less" },
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			})
			lspconfig.solargraph.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<S-F12>", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<C-F12>", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {})
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {})
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, {})
			
			-- VS Code style shortcuts
			vim.keymap.set("n", "<C-S-F12>", vim.lsp.buf.declaration, {}) -- Go to declaration
			vim.keymap.set("n", "<A-F12>", vim.lsp.buf.definition, {}) -- Peek definition
			vim.keymap.set("n", "<C-Space>", vim.lsp.buf.completion, {}) -- Trigger completion
			vim.keymap.set("n", "<C-S-Space>", vim.lsp.buf.signature_help, {}) -- Trigger parameter hints
			vim.keymap.set("n", "<A-Enter>", vim.lsp.buf.code_action, {}) -- Quick fix
			vim.keymap.set("n", "<S-A-F12>", vim.lsp.buf.references, {}) -- Find all references
		end,
	},
}
