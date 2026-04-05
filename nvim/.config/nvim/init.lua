-----------------------------------------------------------------------------
-- 1. BOOTSTRAP: Automatically install lazy.nvim if it's missing
-----------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

  -- Handle errors during cloning
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Add lazy.nvim to the Neovim runtime path
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------------------------
-- 2. OPTIONS: Load basic Neovim settings (indentation, line numbers, etc.)
-----------------------------------------------------------------------------
require("config.options")
require("config.keymaps")
require("config.diagnostics")

-----------------------------------------------------------------------------
-- 3. PLUGINS: Initialize the plugin manager and import modules
-----------------------------------------------------------------------------
require("lazy").setup({
  spec = {
    -- Import all plugin files/folders from specific categories
    { import = "plugins.lsp" },    -- Loads everything in lua/plugins/lsp/
    { import = "plugins.editor" }, -- Loads everything in lua/plugins/editor/
    { import = "plugins.ui" },     -- Loads everything in lua/plugins/ui/
    { import = "plugins.lang" },   -- Loads everything in lua/plugins/lang/
  },
})
