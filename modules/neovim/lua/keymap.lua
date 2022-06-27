local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


--Remap space as leader key
map('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

--Add move line shortcuts
map('n', '<A-j>', ':m .+1<CR>==', { noremap = true })
map('n', '<A-k>', ':m .-2<CR>==', { noremap = true })
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true })
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true })

--Remap escape to leave terminal mode
map('t', '<Esc>', [[<c-\><c-n>]], { noremap = true })


--Add map to enter paste mode
vim.o.pastetoggle = '<F3>'

map('n', '<leader>bm', '<cmd>lua ToggleMouse()<cr>', { noremap = true })

--Start interactive EasyAlign in visual mode (e.g. vipga)
-- Note this overwrites a useful ascii print thing
-- map('x', 'ga', '<Plug>(EasyAlign)', {})

--Start interactive EasyAlign for a motion/text object (e.g. gaip)
-- map('n', 'ga', '<Plug>(EasyAlign)', {})
--Add leader shortcuts
map('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<cr>]], { noremap = true, silent = true })
map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers({sort_lastused = true})<cr>]], { noremap = true, silent = true })
map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { noremap = true, silent = true })
map('n', '<leader>h', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], { noremap = true, silent = true })
map('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<cr>]], { noremap = true, silent = true })
map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], { noremap = true, silent = true })
map('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], { noremap = true, silent = true })
map('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true })
map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<cr>]], { noremap = true, silent = true })
map('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], { noremap = true, silent = true })
map('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], { noremap = true, silent = true })
map('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], { noremap = true, silent = true })
map('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], { noremap = true, silent = true })
map('n', '<leader>wo', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]], { noremap = true, silent = true })

-- Fugitive shortcuts
map('n', '<leader>ga', ':Git add %:p<CR><CR>', { noremap = true, silent = true })
map('n', '<leader>gg', ':GBrowse<CR>', { noremap = true, silent = true })
map('n', '<leader>gd', ':Gdiff<CR>', { noremap = true, silent = true })
map('n', '<leader>ge', ':Gedit<CR>', { noremap = true, silent = true })
map('n', '<leader>gr', ':Gread<CR>', { noremap = true, silent = true })
map('n', '<leader>gw', ':Gwrite<CR><CR>', { noremap = true, silent = true })
map('n', '<leader>gl', ':silent! Glog<CR>:bot copen<CR>', { noremap = true, silent = true })
map('n', '<leader>gm', ':Gmove<Space>', { noremap = true, silent = true })
map('n', '<leader>go', ':Git checkout<Space>', { noremap = true, silent = true })

-- alternative shorcuts without fzf
map('n', '<leader>,', ':buffer *', { noremap = true })
map('n', '<leader>.', ':e<space>**/', { noremap = true })
map('n', '<leader>sT', ':tjump *', { noremap = true })

-- Managing quickfix list
map('n', '<leader>qo', ':copen<CR>', { noremap = true, silent = true })
map('n', '<leader>qq', ':cclose<CR>', { noremap = true, silent = true })

-- Managing buffers
map('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true })

-- Random
map('n', '<leader>;', ':', { noremap = true, silent = false })

-- LSP management
map('n', '<leader>lr', ':LspRestart<CR>', { noremap = true, silent = true })
map('n', '<leader>li', ':LspInfo<CR>', { noremap = true, silent = true })
map('n', '<leader>ls', ':LspStart<CR>', { noremap = true, silent = true })
map('n', '<leader>lt', ':LspStop<CR>', { noremap = true, silent = true })

-- Neovim management
map('n', '<leader>nu', ':PackerUpdate<CR>', { noremap = true, silent = true })
map('n', '<leader>nc', ':e $HOME/Repositories/nix/nix-dotfiles/home-manager/configs/neovim/init.lua<CR>', { noremap = true, silent = true })

-- Remap number increment to alt
map('n', '<A-a>', '<C-a>', { noremap = true })
map('v', '<A-a>', '<C-a>', { noremap = true })
map('n', '<A-x>', '<C-x>', { noremap = true })
map('v', '<A-x>', '<C-x>', { noremap = true })

-- n always goes forward
map('n', 'n', "'Nn'[v:searchforward]", { noremap = true, expr = true })
map('x', 'n', "'Nn'[v:searchforward]", { noremap = true, expr = true })
map('o', 'n', "'Nn'[v:searchforward]", { noremap = true, expr = true })
map('n', 'N', "'nN'[v:searchforward]", { noremap = true, expr = true })
map('x', 'N', "'nN'[v:searchforward]", { noremap = true, expr = true })
map('o', 'N', "'nN'[v:searchforward]", { noremap = true, expr = true })

-- Y yank until the end of line
map('n', 'Y', 'y$', { noremap = true })

-- Clear white space on empty lines and end of line
map('n', '<F6>', [[:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]], { noremap = true, silent = true })


map('n', '<leader>wt', ':lua ToggleNetrw()<cr><paste>', { noremap = true, silent = true })

-- Telescope 
map('n', '<leader>os', [[<cmd>lua require('telescope.builtin').live_grep({search_dirs={'$HOME/Nextcloud/org'}})<cr>]], { noremap = true, silent = true })
map('n', '<leader>of', [[<cmd>lua require('telescope.builtin').find_files({search_dirs={'$HOME/Nextcloud/org'}})<cr>]], { noremap = true, silent = true })

-- Trigger linting
map('n', '<leader>bl', "<cmd>lua require('lint').try_lint()<CR>", { noremap = true, silent = true })


