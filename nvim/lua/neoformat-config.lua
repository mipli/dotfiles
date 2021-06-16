local utils = require('utils')

utils.create_augroup({
  {'BufWritePre', '*', ':undojoin | Neoformat'},
}, 'Format')
