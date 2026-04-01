return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "tomasiser/vim-code-dark",
  },
  config = function()
    local p10k_theme = {
      normal = {
        a = { fg = "#000000", bg = "#569CD6", gui = "bold" },
        b = { fg = "#D4D4D4", bg = "#3C3C3C" },
        c = { fg = "#D4D4D4", bg = "#1E1E1E" },
      },
      insert = {
        a = { fg = "#000000", bg = "#608B4E", gui = "bold" },
      },
      visual = {
        a = { fg = "#000000", bg = "#C586C0", gui = "bold" },
      },
      replace = {
        a = { fg = "#000000", bg = "#D16969", gui = "bold" },
      },
      command = {
        a = { fg = "#000000", bg = "#DCDCAA", gui = "bold" },
      },
      inactive = {
        a = { fg = "#D4D4D4", bg = "#3C3C3C" },
        b = { fg = "#D4D4D4", bg = "#1E1E1E" },
        c = { fg = "#D4D4D4", bg = "#1E1E1E" },
      },
    }

    require("lualine").setup({
      options = {
        theme = p10k_theme,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1, symbols = { modified = " [+]", readonly = " [RO]" } } },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      tabline = {
        lualine_a = { { "buffers" } },
        lualine_z = { { "tabs" } },
      },
    })
  end,
}
