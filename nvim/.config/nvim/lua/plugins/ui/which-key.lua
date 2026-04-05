return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Loads only when needed to keep startup fast
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300 -- Time to wait for a mapped sequence (ms)
    end,
    opts = {
      -- Style settings
      preset = "modern", -- Clean, modern look

      -- Delay before the popup appears
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,

      -- Document/Group names (Optional: adds clean headers to the popup)
      spec = {
        { "<leader>b", group = "Buffers", icon = "󰈙 " },
        { "<leader>c", group = "Code/LSP", icon = "󰌶 " },
        { "<leader>f", group = "Find", icon = "󰍉 " },
        { "<leader>g", group = "Git", icon = "󰊢 " },
        { "<leader>h", group = "Git Hunks", icon = "" },
        { "<leader>q", group = "Quit", icon = "󰗼 " },
        { "<leader>t", group = "Toggles", icon = "󰔡 " },
        { "<leader>w", group = "Windows", icon = "󰍹 " },
        { "<leader>x", group = "Diagnostics", icon = "󱖫 " },
        { "<localleader>l", group = "VimTeX (LaTeX)", icon = " ", mode = "n" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (Which-key)",
      },
    },
  },
}
