local utils = require('utils');

local options = {noremap = true, silent = true}

--- {{{ General mappings
utils.map('n', 'Q', '<nop>', {noremap = true})
utils.map('n', ';', ':', {noremap = true})

utils.map('v', 'J', [[:m '>+1<cr>gv=gv]], {noremap = true})
utils.map('v', 'J', [[:m '>+1<cr>gv=gv]], {noremap = true})
utils.map('v', 'K', [[:m '<-2<cr>gv=gv]], {noremap = true})

utils.map('n', '<Tab>', ':tabnext<cr>', {noremap = true})
utils.map('n', '<S-Tab>', ':tabprev<cr>', {noremap = true})

utils.map('n', '<C-J>', '<C-W><C-J>', options)
utils.map('n', '<C-K>', '<C-W><C-K>', options)
utils.map('n', '<C-L>', '<C-W><C-L>', options)
utils.map('n', '<C-H>', '<C-W><C-H>', options)
--- }}}

--- {{{ Commenting
utils.map("n", "<leader>/", ":CommentToggle<CR>", options)
utils.map("v", "<leader>/", ":CommentToggle<CR>", options)
--- }}}

-- {{{ compe completion
utils.map('n', '<C-Space>', 'compe#complete()',
          {noremap = true, silent = true, expr = true})
utils.map('i', '<CR>', 'compe#confirm(\'<CR>\')',
          {noremap = true, silent = true, expr = true})
utils.map('i', '<C-e>', 'compe#close()',
          {noremap = true, silent = true, expr = true})
-- }}}

-- {{{ diagnostic
utils.map_lua('n', 'g[', [[vim.lsp.diagnostic.goto_prev()]], options)
utils.map_lua('n', 'g]', [[vim.lsp.diagnostic.goto_next()]], options)
-- }}}

-- {{{ vsnip
utils.map('i', '<C-j>',
          [[vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>']],
          {expr = true})
utils.map('s', '<C-j>',
          [[vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>']],
          {expr = true})

utils.map('i', '<C-j>',
          [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']],
          {expr = true})
utils.map('s', '<C-j>',
          [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']],
          {expr = true})
-- }}}

-- {{{ lsp
utils.map_lua('n', '<c-]>', [[vim.lsp.buf.definition()]], options)
utils.map_lua('n', 'gD', [[vim.lsp.buf.implementation()]], options)
utils.map_lua('n', '<c-K>', [[vim.lsp.buf.signature_help()]], options)
utils.map_lua('n', 'K', [[vim.lsp.buf.hover()]], options)
utils.map_lua('n', 'gT', [[vim.lsp.buf.type_definition()]], options)
utils.map_lua('n', 'grf', [[vim.lsp.buf.references()]], options)
utils.map_lua('n', 'g0', [[vim.lsp.buf.document_symbol()]], options)
utils.map_lua('n', 'gW', [[vim.lsp.buf.workspace_symbol()]], options)
utils.map_lua('n', 'ga', [[vim.lsp.buf.code_action()]], options)
-- }}}

-- {{{ telescope
utils.map_lua('n', '<leader>sf', [[require'telescope.builtin'.git_files{}]],
              options)
utils.map_lua('n', '<leader>p', [[require'telescope.builtin'.find_files{}]],
              options)
utils.map_lua('n', '<leader>rg', [[require'telescope.builtin'.live_grep{}]],
              options)
utils.map_lua('n', '<leader>ls',
              [[require'telescope.builtin'.lsp_references{}]], options)
utils.map_lua('n', '<leader>ws',
              [[require'telescope.builtin'.lsp_workspace_symbols{}]], options)
utils.map_lua('n', '<leader>ds',
              [[require'telescope.builtin'.lsp_document_symbols{}]], options)
utils.map_lua('n', '<leader>dg',
              [[require'telescope.builtin'.lsp_document_diagnostics{}]], options)
utils.map_lua('n', '<leader>wg',
              [[require'telescope.builtin'.lsp_workspace_diagnostics{}]],
              options)
utils.map_lua('n', '<leader>ld',
              [[require'telescope.builtin'.lsp_definition{}]], options)
-- }}}
