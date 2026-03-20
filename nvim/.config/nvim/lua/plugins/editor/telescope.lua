return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")

      -- KEYMAPS

      -- <leader>ff: Find Files
      -- Updated to search hidden files (starting with .) and ignored files (in .gitignore)
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({
          hidden = true,     -- Search hidden files (e.g., .bashrc)
          no_ignore = true,  -- Do not respect .gitignore
        })
      end, { desc = "Telescope find files (including hidden & ignored)" })

      -- <leader>fg: Live Grep
      -- Updated to search text inside hidden and ignored files
      vim.keymap.set("n", "<leader>fg", function()
        builtin.live_grep({
          -- Pass additional arguments to ripgrep (rg) to search hidden/ignored files
          additional_args = function(args)
            return vim.list_extend(args, { "--hidden", "--no-ignore" })
          end,
          -- IMPORTANT: Explicitly ignore the .git directory to prevent lag and noise
          file_ignore_patterns = { ".git/" }, 
        })
      end, { desc = "Telescope live grep (including hidden & ignored)" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      -- This setup configures the UI look and loads the extension
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
