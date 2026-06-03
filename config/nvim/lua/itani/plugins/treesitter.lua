-- nvim-treesitter `main` branch (the rewrite) — required for Neovim 0.11+/0.12.
-- The legacy `master` branch breaks on 0.12 (query_predicates vs the new
-- treesitter runtime). On `main` the plugin is a parser manager; highlighting
-- and indentation are driven by Neovim's native vim.treesitter.
local PARSERS = {
  "lua", "vim", "vimdoc", "query",
  "javascript", "typescript", "tsx",
  "json", "jsonc", "yaml", "toml",
  "bash", "go", "gomod", "python", "scala",
  "markdown", "markdown_inline", "http",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()

    -- Install/update the parsers we use (async; downloads on first run).
    pcall(function()
      require("nvim-treesitter").install(PARSERS)
    end)

    -- Start native treesitter highlighting + indentation per buffer.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
        if not lang then return end
        if not pcall(vim.treesitter.language.add, lang) then return end
        pcall(vim.treesitter.start, ev.buf, lang)
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
