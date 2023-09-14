return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    local nvimtree = require('nvim-tree')

    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    
    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true
    
    -- empty setup using defaults
    require("nvim-tree").setup()
    
    -- OR setup with some options
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })


    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>tf", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>tc", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end,
}
