return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify", -- Beautiful notification popups
  },
  opts = {
    presets = {
      bottom_search = false,        -- Use floating window for search (/) too
      command_palette = true,       -- Floating command line at the center
      long_message_to_split = true, -- Send long error messages to a split window
      lsp_doc_border = true,        -- Add borders to LSP hover documentation
    },
    cmdline = {
      view = "cmdline_popup", -- Classic command palette style
    },
  }
}
