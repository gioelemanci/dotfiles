return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter", -- Starts only when you begin typing, saving RAM
  config = function()
    require("copilot").setup({
      panel = {
        enabled = false, -- Disable the side panel, we only want inline text
      },
      suggestion = {
        enabled = true,
        auto_trigger = true, -- Show gray suggestions automatically while typing
        keymap = {
          accept = "<C-l>", -- Press Ctrl+L to accept the whole suggestion
          accept_word = "<C-Right>", -- Accept only the next word
          accept_line = false,
          next = "<C-Down>", -- Cycle through Copilot suggestions
          prev = "<C-Up>",
          dismiss = "<C-e>", -- Dismiss the suggestion
        },
      },
      filetypes = {
        yaml = false,
        markdown = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        ["."] = false,
        -- Explicitly enable LaTeX (and other languages you'll use)
        tex = true,
        python = true,
        cpp = true,
        lua = true,
        -- c = true,
      },
    })
  end,
}
