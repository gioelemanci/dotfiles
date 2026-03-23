return {

  -- vim-fugitive: The premier Git wrapper for Vim
  {
    "tpope/vim-fugitive",
    config = function()
      -- Keymaps for Fugitive
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })
      vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git Commit" })
      vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git Push" })
      vim.keymap.set("n", "<leader>gl", ":Git log --oneline --graph --all<CR>", { desc = "Git Log" })

      -- Conflict resolution (DiffGet)
      vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>", { desc = "Git DiffGet (Left/Target)" })
      vim.keymap.set("n", "<leader>gr", ":diffget //3<CR>", { desc = "Git DiffGet (Right/Merge)" })
    end,
  },

  -- gitsigns: Visual feedback and hunk management
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      -- Inline blame (dimmed text at the end of the line)
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
        virt_text_pos = 'eol',
      },

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation through changes (Hunks)
        map('n', ']h', function()
          if vim.wo.diff then return ']h' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = "Next Hunk" })

        map('n', '[h', function()
          if vim.wo.diff then return '[h' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = "Previous Hunk" })

        -- Hunk Actions
        map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage Hunk" })
        map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset Hunk" })
        map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage Entire File" })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview Hunk (Popup)" })
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "Full Blame" })

        -- UI Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle Inline Blame" })
        map('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle Deleted Lines" })
      end
    },
  },
}
