return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  opts = {
    close_if_last_window = true, -- Close Neovim if Neo-tree is the last window
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,

    -- Aesthetic configurations
    default_component_configs = {
      indent = {
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        indent_size = 2,
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "",
      },
      git_status = {
        symbols = {
          -- Modern symbols for Git
          added     = "✚",
          modified  = "",
          untracked = "",
          ignored   = "",
          unstaged  = "󰄱",
          staged    = "",
          conflict  = "",
        }
      },
    },

    window = {
      position = "left",
      width = 30,
    },

    filesystem = {
      follow_current_file = {
        enabled = true, -- Automatically focus the currently opened file
      },
      filtered_items = {
        visible = false, -- Hide hidden files by default (Press 'H' in Neo-tree to toggle)
        hide_dotfiles = false,
        hide_gitignored = false,
      }
    }
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", { desc = "Neo-tree: Reveal current file" })
    vim.keymap.set("n", "<C-b>", ":Neotree close<CR>", { desc = "Neo-tree: Close sidebar" })
  end,
}
