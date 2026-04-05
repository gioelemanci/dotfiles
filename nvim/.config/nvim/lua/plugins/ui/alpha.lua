return {
  "goolord/alpha-nvim",
  event = "VimEnter", -- Load immediately when Vim starts
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local dashboard = require("alpha.themes.dashboard")

    -- 1. HEADER (Modern Neovim Logo)
    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }

    -- 2. BUTTONS 
    -- Format: dashboard.button(shortcut_key, text, command)
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("n", "  New File", "<cmd>ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("g", "  Find Text", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("e", "󰙅  File Explorer", "<cmd>Neotree toggle<CR>"),
      dashboard.button("l", "󰒲  Lazy Plugins", "<cmd>Lazy<CR>"),
      dashboard.button("q", "󰅙  Quit", "<cmd>qa<CR>"),
    }

    -- 3. AESTHETICS & HIGHLIGHTS
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"

    -- Apply the layout
    dashboard.config.layout = {
      { type = "padding", val = 4 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    require("alpha").setup(dashboard.opts)
  end,
}
