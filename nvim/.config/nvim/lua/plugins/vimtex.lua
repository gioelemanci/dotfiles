return {
    "lervag/vimtex",
    lazy = false, -- Must be loaded at startup to handle filetypes correctly
    init = function()
      -- Use Zathura as the PDF viewer (Best choice for Arch Linux)
      vim.g.vimtex_view_method = "zathura"

      -- Do not open the QuickFix window automatically on warnings
      vim.g.vimtex_quickfix_mode = 0

      -- Optional: Enable feature concealment (e.g., show Greek symbols like λ instead of \lambda)
      vim.g.tex_conceal = "abdmg"
    end,
  }
