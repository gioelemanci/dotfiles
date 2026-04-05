return {
  "lervag/vimtex",
  lazy = false, -- Must be loaded at startup to handle filetypes correctly
  init = function()
    -- Use Zathura as the PDF viewer (Best choice for Arch Linux)
    vim.g.vimtex_view_method = "zathura"

    -- Do not open the QuickFix window automatically on warnings
    vim.g.vimtex_quickfix_mode = 0

    -- More
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_syntax_enabled = 1
  end,
}
