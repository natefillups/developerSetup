return {
  'vim-airline/vim-airline',
  dependencies = {
    'vim-airline/vim-airline-themes'
  },
  config = function()
    vim.g["airline#theme"] = 'codedark'

    vim.g["airline#extensions#tabline#enabled"] = 1

    vim.g["airline#extensions#tabline#formatter"] = 'default'

    vim.cmd([[set statusline=]])
    vim.cmd([[set statusline+=\ %F\ %M\ %Y\ %R]])
    vim.cmd([[set statusline+=%=]])
    vim.cmd([[set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%]])
    vim.cmd([[set laststatus=2]])
  end,
}
