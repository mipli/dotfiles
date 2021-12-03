local utils = require('utils');
local nvim_lsp = require'lspconfig'

local opts = {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    runnables = {
      use_telescope = true
    },
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {}, -- rust-analyer options
}

require('rust-tools').setup(opts)

require'lspconfig'.sumneko_lua.setup {
  cmd = {"/home/michael/local/language-servers/lua-language-server/bin/Linux/lua-language-server", "-E", "/home/michael/local/language-servers/lua-language-server/main.lua"},
  settings = {
    Lua = {
      runtime = {
	-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
	version = 'LuaJIT',
	-- Setup your lua path
	path = vim.split(package.path, ';')
      },
      diagnostics = {
	-- Get the language server to recognize the `vim` global
	globals = {'vim'}
      },
      workspace = {
	-- Make the server aware of Neovim runtime files
	library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
      }
    }
  }
}

local on_attach = function(_, _)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = { 'html', 'cssls', 'jsonls', 'pyright', 'ccls', 'dartls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities=capabilities,
    on_attach = on_attach,
  }
end

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  update_in_insert = true,
}
)

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
  };
}


vim.o.updatetime = 300
utils.create_augroup({
  {'CursorHold', '*', 'lua vim.lsp.diagnostic.show_line_diagnostics()'}
}, 'Lsp')
