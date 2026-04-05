return {
  -- Tokyo Night Storm (Current Default)
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = false,
    priority = 1000,
    config = function()
      -- Imposta la variante "storm" come tema di avvio
      vim.cmd.colorscheme("tokyonight-storm")
    end,
  },

  -- Catppuccin 
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },

  -- Kanagawa (Elegant, inspired by Japanese art)
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = false,
    priority = 1000
  },

  -- Rose Pine (Cozy and warm)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000
  },
}
