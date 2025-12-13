return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
			ensure_installed = {
				"lua-language-server",
				"xmlformatter",
				"csharpier",
				"prettier",
				"stylua",
				"bicep-lsp",
				"html-lsp",
				"css-lsp",
				"eslint-lsp",
				"typescript-language-server",
				"json-lsp",
				"rust-analyzer",

				-- !
				"roslyn",
				-- "csharp-language-server",
				-- "omnisharp",
			},
		},
  },
  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    ft = { "cs", "razor" },
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  },
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
			ensure_installed = { "lua_ls", "ts_ls", "eslint", "emmet_ls", "cssls", "tailwindcss" },
			automatic_enable = true,
		},
  },
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("roslyn", {})

			-- Configure servers using vim.lsp.config (Nvim 0.11+)
			vim.lsp.config("ts_ls", {
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

			vim.lsp.config("eslint", {
				capabilities = capabilities,
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
				settings = {
					workingDirectory = { mode = "auto" },
				},
			})

			vim.lsp.config("emmet_ls", {
				capabilities = capabilities,
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
			})

			vim.lsp.config("cssls", {
				capabilities = capabilities,
				filetypes = { "css", "scss", "less" },
			})

			vim.lsp.config("tailwindcss", {
				capabilities = capabilities,
				filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			})

			vim.lsp.config("solargraph", {
				capabilities = capabilities,
			})

			vim.lsp.config("html", {
				capabilities = capabilities,
			})

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})

			-- Enable servers (mason-lspconfig handles this with automatic_enable = true)
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("eslint")
			vim.lsp.enable("emmet_ls")
			vim.lsp.enable("cssls")
			vim.lsp.enable("tailwindcss")
			vim.lsp.enable("solargraph")
			vim.lsp.enable("html")
			vim.lsp.enable("lua_ls")

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
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
			vim.keymap.set("n", "<leader>q", function()
				if vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 then
					vim.cmd("lclose")
				else
					vim.diagnostic.setloclist()
				end
			end, {})
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

			-- Diagnostic configuration for tiny-inline-diagnostic
			vim.diagnostic.config({
				underline = false,
				virtual_text = false,
				update_in_insert = false,
				severity_sort = true,
				signs = {
					text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
					},
				},
			})

			vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
				virtual_text = false,
			})
		end,
	},
}
