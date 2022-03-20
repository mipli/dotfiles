local utils = require("utils")

local options = { noremap = true, silent = true }

--- {{{ General mappings
utils.map("n", "Q", "<nop>", { noremap = true })
utils.map("n", ";", ":", { noremap = true })

utils.map("v", "J", [[:m '>+1<cr>gv=gv]], { noremap = true })
utils.map("v", "J", [[:m '>+1<cr>gv=gv]], { noremap = true })
utils.map("v", "K", [[:m '<-2<cr>gv=gv]], { noremap = true })

utils.map("n", "<Tab>", ":tabnext<cr>", { noremap = true })
utils.map("n", "<S-Tab>", ":tabprev<cr>", { noremap = true })

utils.map("n", "<C-J>", "<C-W><C-J>", options)
utils.map("n", "<C-K>", "<C-W><C-K>", options)
utils.map("n", "<C-L>", "<C-W><C-L>", options)
utils.map("n", "<C-H>", "<C-W><C-H>", options)
--- }}}

--- {{{ Commenting
utils.map("n", "<leader>/", ":CommentToggle<CR>", options)
utils.map("v", "<leader>/", ":CommentToggle<CR>", options)
--- }}}

-- {{{ diagnostic
utils.map_lua("n", "g[", [[vim.lsp.diagnostic.goto_prev()]], options)
utils.map_lua("n", "g]", [[vim.lsp.diagnostic.goto_next()]], options)
-- }}}

-- {{{ vsnip
utils.map("i", "<C-j>", [[vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>']], { expr = true })
utils.map("s", "<C-j>", [[vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>']], { expr = true })

utils.map("i", "<C-j>", [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']], { expr = true })
utils.map("s", "<C-j>", [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']], { expr = true })
-- }}}

-- {{{ lsp
utils.map_lua("n", "<c-]>", [[vim.lsp.buf.definition()]], options)
utils.map_lua("n", "K", [[vim.lsp.buf.hover()]], options)
-- }}}

-- {{{ trouble
utils.map("n", "<M-t>", ":TroubleToggle<CR>", options)
-- }}}

-- {{{ zenmode
utils.map("n", "<M-z>", ":ZenMode<CR>", options)
-- }}}
