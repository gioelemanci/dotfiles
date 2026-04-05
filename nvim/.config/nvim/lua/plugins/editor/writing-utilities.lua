return {

  -- nvim-autopairs: Auto-close brackets () [] {} ""
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      local npairs = require("nvim-autopairs")

      npairs.setup({
        check_ts = true, -- Use Treesitter
        map_cr = true,   -- Map <CR>
      })

      -- nvim-cmp integration
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- nvim-surround: Add/Change/Delete surrounding characters
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- cs"'  -> Change " to '
        -- ds"   -> Delete "
        -- ysiw] -> Surround word with []
      })
    end,
  },

  -- Rainbow Delimiters: Colorize matching brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },

  -- vim-illuminate: Automatically highlight other uses of the word under the cursor
  {
    "RRethy/vim-illuminate",
    config = function()
      require('illuminate').configure({
        delay = 200, -- Highlight delay (ms)

        -- Filetypes to ignore
        -- filetypes_denylist = {
        --     'dirbuf', 'dirvish', 'fugitive', 'alpha', 'neo-tree', 'TelescopePrompt'
        -- },
      })
    end,
  },
}
