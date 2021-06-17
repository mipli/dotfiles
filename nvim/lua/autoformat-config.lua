local utils = require('utils')

utils.create_augroup({
  {'BufWritePre', '*.py', ':Autoformat'},
  {'BufWritePre', '*.rs', ':Autoformat'},
  {'BufWritePre', '*.lua', ':Autoformat'},
  {'BufWritePre', '*.js', ':Autoformat'},
}, 'Format')

vim.cmd [[ let g:formatdef_tf = '"terraform fmt -"' ]]
vim.cmd [[ let g:formatters_tf = ['tf'] ]]
