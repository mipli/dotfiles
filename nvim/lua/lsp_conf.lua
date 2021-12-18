local nvim_lsp = require("lspconfig")
local lsp_status = require("lsp-status")
lsp_status.register_progress()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local on_attach = function(client, bufnr)
	lsp_status.on_attach(client, bufnr)
	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
end

require("rust-tools").setup({
	tools = {
		autoSetHints = true,
		inlay_hints = {
			hover_with_actions = true,
			only_current_line = false,
			show_parameter_hints = true,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
		debuggables = {
			use_telescope = true,
		},
		runnables = {
			use_telescope = true,
		},
		crate_graph = {
			backend = "xlib",
		},
	},
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			-- to enable rust-analyzer settings visit:
			-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
			["rust-analyzer"] = {
				assist = {
					importGranularity = "module",
					importPrefix = "by_self",
				},
				diagnostics = {
					-- https://github.com/rust-analyzer/rust-analyzer/issues/6835
					disabled = { "unresolved-macro-call" },
				},
				completion = {
					autoimport = {
						enable = true,
					},
					postfix = {
						enable = true,
					},
				},
				cargo = {
					loadOutDirsFromCheck = true,
					autoreload = true,
					runBuildScripts = true,
				},
				procMacro = {
					enable = true,
				},
				lens = {
					enable = true,
					run = true,
					methodReferences = true,
					implementations = true,
				},
				hoverActions = {
					enable = true,
				},
				inlayHints = {
					chainingHintsSeparator = "‣ ",
					typeHintsSeparator = "‣ ",
					typeHints = true,
				},
				checkOnSave = {
					enable = true,
					command = "clippy",
					allFeatures = true,
				},
			},
		},
	},
})

nvim_lsp.sumneko_lua.setup({
	cmd = {
		"/home/michael/local/language-servers/lua-language-server/bin/Linux/lua-language-server",
		"-E",
		"/home/michael/local/language-servers/lua-language-server/main.lua",
	},
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})

local servers = { "html", "cssls", "jsonls", "pyright", "ccls", "dartls" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = true,
	virtual_text = false,
	signs = true,
})

-- show icons in the sidebar
local signs = { Error = " ", Warn = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	severity_sort = true,
})

require("null-ls").setup({
	debug = true,
	sources = {
		require("null-ls").builtins.formatting.dart_format,
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.diagnostics.eslint,
		-- require("null-ls").builtins.completion.aspell,
	},
})
