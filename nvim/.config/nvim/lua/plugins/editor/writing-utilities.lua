return {

  -- nvim-autopairs: Auto-close brackets () [] {} ""
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" }, -- Depends on your completion engine
    config = function()
      local npairs = require("nvim-autopairs")

      npairs.setup({
        check_ts = true, -- Use Treesitter to check for pairs (smarter)
        map_cr = true,   -- Map the <CR> key
      })

      -- Integration with nvim-cmp:
      -- Automatically adds parenthesis when you select a function from the completion menu
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- nvim-surround: Add/Change/Delete surrounding characters
  {
    "kylechui/nvim-surround",
    version = "*", -- Use the latest stable version
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Usage examples:
        --  cs"'  -> Change Surround " to '
        --  ds"   -> Delete Surround "
        --  ysiw] -> You Surround Inner Word with []
      })
    end,
  },

  -- Rainbow Delimiters: Colorize matching brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- Load when opening a file
  },
}
