vim.diagnostic.config({
  -- Virtual text (inline messages to the right of the code)
  virtual_text = {
    spacing = 4,           -- Gap between code and message
    source = "if_many",    -- Show source if multiple LSPs are active
    prefix = "●",          -- Prefix icon ("■" or "" also look good)
  },

  -- Underline the problematic code
  underline = true,

  -- Don't update diagnostics while typing (Insert mode) to avoid distraction
  update_in_insert = false,

  -- Sort by severity: Errors first, then Warnings
  severity_sort = true,

  -- Icons in the left gutter
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ", -- Error
      [vim.diagnostic.severity.WARN]  = " ", -- Warning
      [vim.diagnostic.severity.HINT]  = " ", -- Hint
      [vim.diagnostic.severity.INFO]  = " ", -- Info
    },
  },
})
