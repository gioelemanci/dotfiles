return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Trouble v3 has great defaults, leaving opts empty uses the modern UI
  },
  keys = {
    -- Project-wide errors
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },

    -- Errors only in the current file
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },

    -- Document outline (Functions/Classes in code, Sections in LaTeX)
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",      desc = "Symbols Outline (Trouble)" },

    -- Quickfix list (Crucial for VimTeX compilation errors)
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)" },

    -- Location list (Used by some search plugins)
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location List (Trouble)" },
  },
}
