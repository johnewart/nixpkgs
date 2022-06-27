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
local wk = require('which-key')

wk.register({
  b = { 
    name = "Buffer", 
    d = { ':bdelete<CR>', "Delete" },
  },
  f = {
    name = 'Find',
    f = {[[<cmd>lua require('telescope.builtin').find_files({previewer = false})<cr>]], "File" },
    b = { [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], "In buffer (fuzzy)" },
    h = { [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], "Help tags" },
    t = { [[<cmd>lua require('telescope.builtin').tags()<cr>]], "Tags" },
    d = { [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], "Grep string" },
    g = { [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], "Live grep" },
    o = { [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<cr>]], "Tags (only buffer)" },
    G = { 
      name = "Git",
      c = { [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], "Commits" },
      b = { [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], "Branches" },
      p = { [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], "Branch commits" },
      s = { [[<cmd>lua require('telescope.builtin').git_status()<cr>]], "Status" },
    },
    D = { [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]], "Symbols" },
  },
  ["<space>"] = { [[<cmd>lua require('telescope.builtin').buffers({sort_lastused = true})<cr>]], "Switch to buffer" },
  L = { "<cmd>lua require('lint').try_lint()<CR>", "Run linter" },
  G = {
    name = "Fugitive",
    a = { ':Git add %:p<CR><CR>', "Add file" },
    b = { ':GBrowse<cr>', "Browse" },
    c = { ':Git checkout<space>', 'Checkout' },
    d = { ':Gdiff<cr>', "Diff" },
    l = { ':silent! Glog<cr>:bot copen<cr>', 'Log' },
    m = { ':Gmove<space>', "Move" },
    r = { ':Gread<cr>', "Read" },
    e = { ':Gedit<cr>', "Edit" },
    w = { ':Gwrite<cr><cr>', "Write" },
  },
  L = { 
    name = "LSP", 
    i = { ':LspInfo<cr>', 'Info' },
    r = { ':LspRestart<cr>', 'Restart' },
    s = { ':LspStart<cr>', 'Start' },
    S = { ':LspStop<cr>', 'Stop' },
  },
  N = { 
    name = "Neovim management",
    c = { ':e $HOME/.config/nixpkgs/modules/neovim/init.lua<cr>', "Edit init.lua" },
    p = {
      name = "Packages", 
      i = { ':PackerInstall<cr>', "Install" },
      s = { ':PackerSync<cr>', "Synchronize" },
      u = { ':PackerUpdate<cr>', "Update" },
    },
  },
  q = { 
    name = "Quickfix",
    o = { ':copen<cr>', "Open" },
    q = { ':cclose<cr>', "Close" }
  },
  w = {
      name = "Workspace",
      s = { "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "Search for symbol" },
      a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "Add folder" },
      r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', "Remove folder" },
      l = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', "List folders" },
   },
}, { prefix = "<leader>" })

    

  -- alternative shorcuts without fzf
  --map('n', '<leader>,', ':buffer *', { noremap = true })
  --map('n', '<leader>.', ':e<space>**/', { noremap = true })
  --map('n', '<leader>sT', ':tjump *', { noremap = true })

-- Managing buffers


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


