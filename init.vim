" -------
" Plugins
" -------
call plug#begin(stdpath('data') . '/plugged')

" LSP
Plug 'neovim/nvim-lspconfig'

" Completion
Plug 'hrsh7th/nvim-compe'

" Telescope
" (dependencies)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" (telescope)
Plug 'nvim-telescope/telescope.nvim'

" Themes
Plug 'romgrk/doom-one.vim'

" Lua Dev Icons
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

" -----
" Theme
" -----
" For some reason, the colorscheme doesn't set correctly with iTerm unless
" termguicolors is set. Once it is set, colorschemes behave as they should.
set termguicolors
colorscheme doom-one

" -------------
" Configuration
" -------------
set tabstop=4
set shiftwidth=4
set expandtab

" Keep a fixed column on the left for diagnostics
set signcolumn=yes

" Completion
"
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
" Setup compe package
lua <<EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    -- luasnip = true;
  };
}
EOF

" LSP
"
lua <<EOF
local nvim_lsp = require'lspconfig'
-- CMake
nvim_lsp.cmake.setup({})
-- Clang
nvim_lsp.clangd.setup({})
-- Python
nvim_lsp.pylsp.setup({})
-- Rust
nvim_lsp.rust_analyzer.setup({})

EOF

" Format on save
" Rust, Python, C, C++, and CMake
autocmd BufWritePre \(*\(.rs\|.py\|.c\|.h\|.cpp\|.hpp\)\)\|CMakeLists.txt lua vim.lsp.buf.formatting_sync(nil, 1000)

let mapleader="\<SPACE>"

" -----------
" Keybindings
" -----------
" Vim Refresh
nnoremap <leader>vr <cmd>source $MYVIMRC<cr>

" Switch to last edited buffer
nnoremap <leader><tab> <cmd>e#<cr>

" Find with telescope
nnoremap <leader>ff <cmd>Telescope file_browser<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
" File shortcuts
nnoremap <leader>fsv <cmd>belowright split $MYVIMRC<cr>

" Windows
nnoremap <leader>ws <cmd>split<cr>
nnoremap <leader>wv <cmd>vsplit<cr>
nnoremap <leader>wq <cmd>wincmd q<cr>
nnoremap <leader>wo <cmd>only<cr>
nnoremap <leader>wh <cmd>wincmd h<cr>
nnoremap <leader>wj <cmd>wincmd j<cr>
nnoremap <leader>wk <cmd>wincmd k<cr>
nnoremap <leader>wl <cmd>wincmd l<cr>
" Is there a way to have additional commands for opening a file with these
" bindings?

" Tabs
nnoremap <leader>tn <cmd>tabnext<cr>
nnoremap <leader>tp <cmd>tabprevious<cr>
nnoremap <leader>tc <cmd>tabclose<cr>
nnoremap <leader>to <cmd>tabonly<cr>
nnoremap <leader>1 1gt<cr>
nnoremap <leader>2 2gt<cr>
nnoremap <leader>3 3gt<cr>
nnoremap <leader>4 4gt<cr>
nnoremap <leader>5 5gt<cr>
nnoremap <leader>6 6gt<cr>
nnoremap <leader>7 7gt<cr>
nnoremap <leader>8 8gt<cr>
nnoremap <leader>9 9gt<cr>

" LSP
nnoremap <leader>ld <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <leader>lh <cmd>lua vim.lsp.buf.hover()<cr>
