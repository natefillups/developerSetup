-- set leader key to space
vim.g.mapleader = " "

local M = {}

local keymap = vim.keymap -- for conciseness

--------------------------------------------------------------------------------
-- General Keymaps
vim.cmd([[
" Navigate split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using CTRL + arrow keys
nnoremap <c-up> <c-w>+
nnoremap <c-down> <c-w>-
nnoremap <c-left> <c-w>>
nnoremap <c-right> <c-w><
]])
