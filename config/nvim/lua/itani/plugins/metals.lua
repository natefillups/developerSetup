-- Scala LSP via nvim-metals (the recommended Scala-on-Neovim setup).
-- metals installs itself on first attach; run :MetalsInstall if prompted.
-- Buffer-local LSP keymaps come from the shared LspAttach autocmd in lsp.lua.
return {
  "scalameta/nvim-metals",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = { "scala", "sbt" },
  opts = function()
    local metals_config = require("metals").bare_config()
    metals_config.capabilities = require("blink.cmp").get_lsp_capabilities()
    return metals_config
  end,
  config = function(self, metals_config)
    local group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      group = group,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
    })
  end,
}
