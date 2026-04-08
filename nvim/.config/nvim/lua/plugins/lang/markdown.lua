return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- Required for syntax and icons
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  -- Lazy load on markdown files
  ft = { "markdown" },
  config = function()
    require("render-markdown").setup({
      heading = {
        sign = false, -- Hide '#' sign
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' }, -- Custom icons for H1-H6
      },
    })
  end,
}
