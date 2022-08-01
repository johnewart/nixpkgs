-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use

require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  -- LSP stuff
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'fatih/vim-go'
  use 'jose-elias-alvarez/typescript.nvim'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use({
    'scalameta/nvim-metals', 
    requires = { 
      { "nvim-lua/plenary.nvim" }, 
      { "mfussenegger/nvim-dap" } 
    }
  })
  use 'bfredl/nvim-luadev'
  use 'tbastos/vim-lua'
  use 'LnL7/vim-nix'
  use 'ziglang/zig.vim'
  use 'simrat39/rust-tools.nvim'
  use { "glepnir/lspsaga.nvim", branch = "main" }
  use 'dart-lang/dart-vim-plugin'
  use 'thosakwe/vim-flutter'


  use 'sar/luasnip.nvim' -- snippets

  -- Show errors in a pane
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }

  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'tpope/vim-vinegar'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-repeat'

  use 'ludovicchabant/vim-gutentags'
  use 'justinmk/vim-dirvish'
  use 'preservim/nerdtree'
  use 'christoomey/vim-tmux-navigator'

  -- themes
  use "rmehri01/onenord.nvim"
  use "FrenzyExists/aquarium-vim"
  use "NLKNguyen/papercolor-theme"
  use "sainnhe/everforest"
  use "rafi/awesome-vim-colorschemes"
  use "cocopon/iceberg.vim"
  use "base16-project/base16-vim"
  use "rakr/vim-one"
  use "cseelus/vim-colors-lucid"
  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua'  
  use 'liuchengxu/space-vim-theme'

  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use 'joshdick/onedark.vim' -- Theme inspired by Atom
  -- use 'itchyny/lightline.vim' -- Fancier statusline
  -- status line bits

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
-- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'mfussenegger/nvim-lint'

  -- use 'hkupty/iron.nvim'
  use 'folke/which-key.nvim'
  
  
end)

--Incremental live completion
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.cmd [[set undofile]]

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd [[colorscheme base16-tokyo-city-dark]]
vim.cmd [[set background=dark]]

--Add spellchecking
vim.cmd [[ autocmd FileType gitcommit setlocal spell ]]
vim.cmd [[ autocmd FileType markdown setlocal spell ]]

--Set statusbar
vim.g.lightline = {
  colorscheme = 'lucid',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

--Fire, walk with me
vim.cmd [[set guifont="Monaco:h18"]]
vim.g.firenvim_config = { localSettings = { ['.*'] = { takeover = 'never' } } }

--Disable numbers in terminal mode
vim.api.nvim_exec(
  [[
  augroup Terminal
    autocmd!
    au TermOpen * set nonu
  augroup end
]],
  false
)

vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false
-- vim.g.indent_blankline_show_current_context = false

-- Toggle to disable mouse mode and indentlines for easier paste
ToggleMouse = function()
  if vim.o.mouse == 'a' then
    vim.cmd [[IndentBlanklineDisable]]
    vim.wo.signcolumn = 'no'
    vim.o.mouse = 'v'
    vim.wo.number = false
    print 'Mouse disabled'
  else
    vim.cmd [[IndentBlanklineEnable]]
    vim.wo.signcolumn = 'yes'
    vim.o.mouse = 'a'
    vim.wo.number = true
    print 'Mouse enabled'
  end
end

--Add neovim remote for vimtex
-- vim.g.vimtex_compiler_progname = 'nvr'
-- vim.g.tex_flavor = 'latex'

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  --extensions = {
  --  fzf = {
  --    override_generic_sorter = true, -- override the generic sorter
  --    override_file_sorter = true, -- override the file sorter
  --    case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
  --    -- the default case_mode is "smart_case"
  --  },
  --},
}
--require('telescope').load_extension 'fzf'

vim.cmd [[autocmd FileType qf nnoremap <buffer> q :cclose<CR>]]

vim.cmd [[autocmd ColorScheme * highlight WhichKeyFloat guifg=ABB2BF guibg=282C34]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=ABB2BF guibg=282C34]]

require('which-key').setup {
  window = {
    border = { '─', '─', '─', ' ', ' ', ' ', ' ', ' ' }, -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 0, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
  },
}

local wk = require 'which-key'
-- As an example, we will the create following mappings:
--  * <leader>ff find files
--  * <leader>fr show recent files
--  * <leader>fb Foobar
-- we'll document:
--  * <leader>fn new file
--  * <leader>fe edit file
-- and hide <leader>1

wk.register({
  ['?'] = 'which_key_ignore',
  [';'] = 'which_key_ignore',
  [','] = 'which_key_ignore',
  ['.'] = 'which_key_ignore',
}, {
  prefix = '<leader>',
})

-- Make gutentags use ripgrep
-- --python-kinds=-iv
-- --exclude=build
-- --exclude=dist
vim.g.gutentags_file_list_command = 'fd'
vim.g.gutentags_ctags_extra_args = { '--python-kinds=-iv' }

-- remove conceal on markdown files
vim.g.markdown_syntax_conceal = 0

-- Configure vim slime to use tmux
-- vim.g.slime_target = "tmux"
-- vim.g.slime_python_ipython = 1
-- vim.g.slime_dont_ask_default = 1
-- vim.g.slime_default_config = {socket_name = "default", target_pane = "{right-of}"}

-- Change preview window location
vim.g.splitbelow = true

-- map :W to :w (helps which-key issue)
vim.cmd [[ command! W  execute ':w' ]]

-- Neovim python support
vim.g.loaded_python_provider = 0

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Nerdtree like sidepanel
-- absolute width of netrw window
vim.g.netrw_winsize = -28

-- do not display info on the top of window
vim.g.netrw_banner = 0

-- sort is affecting only: directories on the top, files below
-- vim.g.netrw_sort_sequence = '[\/]$,*'

-- variable for use by ToggleNetrw function
vim.g.NetrwIsOpen = 0

-- Lexplore toggle function
ToggleNetrw = function()
  if vim.g.NetrwIsOpen == 1 then
    local i = vim.api.nvim_get_current_buf()
    while i >= 1 do
      if vim.bo.filetype == 'netrw' then
        vim.cmd([[ silent exe "bwipeout " . ]] .. i)
      end
      i = i - 1
    end
    vim.g.NetrwIsOpen = 0
    vim.g.netrw_liststyle = 0
    vim.g.netrw_chgwin = -1
  else
    vim.g.NetrwIsOpen = 1
    vim.g.netrw_liststyle = 3
    vim.cmd [[silent Lexplore]]
  end
end


-- Function to open preview of file under netrw
vim.api.nvim_exec(
  [[
  augroup Netrw
    autocmd!
    autocmd filetype netrw nmap <leader>; <cr>:wincmd W<cr>
  augroup end
]],
  false
)

-- directory managmeent, including autochdir
-- vim.cmd[[nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>]]

-- vim.api.nvim_exec([[
--   augroup BufferCD
--     autocmd!
--     autocmd BufEnter * silent! Glcd
--   augroup end
-- ]], false)

vim.api.nvim_exec(
  [[
  augroup nvim-luadev
    autocmd!
    function! SetLuaDevOptions()
      nmap <buffer> <C-c><C-c> <Plug>(Luadev-RunLine)
      vmap <buffer> <C-c><C-c> <Plug>(Luadev-Run)
      nmap <buffer> <C-c><C-k> <Plug>(Luadev-RunWord)
      map  <buffer> <C-x><C-p> <Plug>(Luadev-Complete)
      set filetype=lua
    endfunction
    autocmd BufEnter \[nvim-lua\] call SetLuaDevOptions()
  augroup end
]],
  false
)

-- Linters
require('lint').linters_by_ft = {
  markdown = {'vale'},
  zsh = {'shellcheck'}
}

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noinsert'
vim.o.completeopt = 'menu,menuone,noselect'

-- local iron = require 'iron'

-- iron.core.set_config {
--   preferred = {
--     python = 'ipython',
--   },
-- }
--

require('lsp')
require("lualine-config")
require('completion-config')
require('keymap')
