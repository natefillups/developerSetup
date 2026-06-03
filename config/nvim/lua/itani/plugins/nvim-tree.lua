return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeCollapse", "NvimTreeRefresh" },
  keys = {
    { "<leader>tt", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    { "<leader>tf", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file explorer on current file" },
    { "<leader>tc", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse file explorer" },
    { "<leader>tr", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" },
  },
  config = function()
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
  end,
}
