return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>sr", function() require("spectre").open() end, desc = "Search and replace" },
    { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Search current word" },
  },
}
