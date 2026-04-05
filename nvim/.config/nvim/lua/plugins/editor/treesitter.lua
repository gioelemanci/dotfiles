return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,        -- Load at startup
  build = ":TSUpdate", -- Run :TSUpdate after installation
  config = function()
    local config = require("nvim-treesitter.configs")

    config.setup({
      -- Ensure these parsers are always installed
      ensure_installed = { "lua", "vim", "vimdoc", "query", "latex", "markdown" },

      -- Automatically install missing parsers when opening a file
      auto_install = true,

      -- Syntax highlighting configuration
      highlight = {
        enable = true,
        disable = { "c" }, -- Disable for C if you prefer
        additional_vim_regex_highlighting = false,
      },

      -- Indentation based on treesitter (better than default)
      indent = { enable = true },
    })
  end,
}
