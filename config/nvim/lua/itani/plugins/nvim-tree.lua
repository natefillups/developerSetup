return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  -- Must load at startup (not lazy) so it can hijack netrw and open the tree
  -- when nvim is launched on a directory, e.g. `nvim ~/Developer/http`.
  lazy = false,
  keys = {
    { "<leader>tt", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    { "<leader>tf", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file explorer on current file" },
    { "<leader>tc", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse file explorer" },
    { "<leader>tr", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" },
  },
  config = function()
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      hijack_netrw = true,
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
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
