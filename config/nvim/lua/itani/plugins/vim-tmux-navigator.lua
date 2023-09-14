return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  config = function()
    vim.g["tmux#navigator#no#mappings"] = 1

    vim.keymap.set('n', "<C-h>", ":<C-U>TmuxNavigateLeft<cr>")
    vim.keymap.set('n', "<C-j>", ":<C-U>TmuxNavigateDown<cr>")
    vim.keymap.set('n', "<C-k>", ":<C-U>TmuxNavigateUp<cr>")
    vim.keymap.set('n', "<C-l>", ":<C-U>TmuxNavigateRight<cr>")
  end,
}
