return {
  "folke/zen-mode.nvim",
  opts = {
    window = {
      width = 90,       -- Text window width
      options = {
        number = false, -- Hide line numbers
        relativenumber = false,
        signcolumn = "no",
        cursorline = false,
      }
    },
    plugins = {
      -- Minimal UI
      options = {
        enabled = true,
        ruler = false,
        showcmd = false,
      },
      twilight = { enabled = true }, -- Dim inactive text (requires twilight.nvim)
    }
  },
  -- Toggle keymap
  keys = {
    { "<leader>tz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
  }
}
