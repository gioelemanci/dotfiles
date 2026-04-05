return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },

    -- Lazy loading: Telescope loads only when these keys are pressed
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",                      desc = "Find Files" },
      { "<leader>fh", "<cmd>Telescope find_files hidden=true<cr>",          desc = "Find Hidden Files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                        desc = "Recent Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",                       desc = "Live Grep (Text)" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",                         desc = "Find in Buffers" },
      { "<leader>th", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Switch Theme" },
    },

    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          -- Globally ignore heavy/useless directories
          file_ignore_patterns = { ".git/", "node_modules/" },
        },
        pickers = {
          find_files = {
            hidden = false, -- Standard search hides dotfiles
          }
        }
      })
    end,
  },

  -- UI-SELECT EXTENSION
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
