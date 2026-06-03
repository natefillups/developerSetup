return {
  "saghen/blink.cmp",
  -- Use a release tag so lazy downloads a prebuilt fuzzy-matcher binary
  -- (no Rust/cargo build required).
  version = "*",
  event = "InsertEnter",
  opts = {
    -- super-tab: <Tab> selects/accepts and jumps snippet placeholders,
    -- <S-Tab> goes back, <CR> accepts — closest to the old CoC muscle memory.
    keymap = {
      preset = "super-tab",
      ["<CR>"] = { "accept", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
