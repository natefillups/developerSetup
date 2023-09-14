vim.g.mapleader = " "

vim.cmd([[filetype on]])
vim.cmd([[filetype plugin on]])
vim.cmd([[filetype indent on]])
vim.cmd([[syntax on]])

vim.cmd([[
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
]])

local opt = vim.opt -- for conciseness

-- Backup
opt.backup = false
-- opt.bex = ''

-- line numbers
opt.relativenumber = true
opt.number = true
opt.ruler = true
opt.scrolloff = 10

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- line wrapping
opt.wrap = false
opt.lbr = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
-- opt.signcolumn = false

-- backspace
opt.backspace = 'indent,eol,start'

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- swapfile
opt.swapfile = false

opt.incsearch = true
opt.showcmd = true
opt.showmode = true
opt.showmatch = true
opt.hlsearch = true
opt.history = 1000
opt.wildmenu = true
opt.wildignore = '*.docx, *.jpg, *.png, *.gif, *.pdf, *.pyc, *.exe, *.flv, *.img, *.xlsx'


