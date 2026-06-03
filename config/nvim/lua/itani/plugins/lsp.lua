return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    -- UX settings formerly set by coc.nvim
    vim.opt.updatetime = 300
    vim.opt.signcolumn = "yes"

    -- Servers to install + enable. Java (jdtls) and Scala (metals) replace the
    -- old coc-java / coc-metals. For heavy Java/Scala work the dedicated
    -- nvim-jdtls / nvim-metals plugins offer more, but mason + lspconfig gives
    -- working LSP out of the box.
    local servers = {
      "ts_ls", "lua_ls", "gopls", "pyright",
      "jsonls", "yamlls", "bashls",
      "jdtls", "metals",
    }

    -- Global defaults applied to every server (Neovim 0.11+ API).
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    -- Per-server overrides.
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_enable = true,
    })

    vim.diagnostic.config({
      virtual_text = true,
      severity_sort = true,
      float = { border = "rounded", source = true },
    })

    -- Buffer-local keymaps once a server attaches (ports the CoC mappings).
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspAttach", {}),
      callback = function(ev)
        local buf = ev.buf
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
        end

        -- navigation
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "K", vim.lsp.buf.hover, "Hover docs")

        -- diagnostics (keep [g / ]g from the CoC setup)
        map("n", "[g", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
        map("n", "]g", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")

        -- actions
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>ac", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>qf", function()
          vim.lsp.buf.code_action({ apply = true, context = { only = { "quickfix" } } })
        end, "Quickfix action")
        map("n", "<leader>cl", vim.lsp.codelens.run, "Run codelens")

        -- telescope-backed lists (replace the CocList <space>* mappings)
        local ok, builtin = pcall(require, "telescope.builtin")
        if ok then
          map("n", "<space>a", builtin.diagnostics, "List diagnostics")
          map("n", "<space>o", builtin.lsp_document_symbols, "Document symbols")
          map("n", "<space>s", builtin.lsp_dynamic_workspace_symbols, "Workspace symbols")
        end

        -- highlight references under cursor on idle (was CocAction('highlight'))
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method("textDocument/documentHighlight") then
          local hl = vim.api.nvim_create_augroup("UserLspHighlight", { clear = false })
          vim.api.nvim_clear_autocmds({ buffer = buf, group = hl })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = buf, group = hl, callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = buf, group = hl, callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- :OR organize imports (replaces the CoC :OR command)
    vim.api.nvim_create_user_command("OR", function()
      vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" } } })
    end, { desc = "Organize imports" })
  end,
}
