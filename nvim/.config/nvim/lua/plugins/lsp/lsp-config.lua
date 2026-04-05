return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Import required modules
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      -- Capabilities for autocompletion (integration with nvim-cmp)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 1. Initialize Mason (Package Manager)
      mason.setup()

      -- 2. Initialize Mason-LSPConfig with "Handlers"
      -- This automates the setup for installed servers and fixes your error
      mason_lspconfig.setup({
        -- List of servers to install automatically
        ensure_installed = { "lua_ls", "texlab", "ltex", "pyright" },

        -- HANDLERS: Define how to setup each server
        handlers = {
          -- A. Default handler: Applies to every server without a specific config
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- B. Specific configuration for Lua
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                },
              },
            })
          end,

          -- C. Specific configuration for LaTeX (TexLab)
          ["texlab"] = function()
            lspconfig.texlab.setup({
              capabilities = capabilities,
              settings = {
                texlab = {
                  build = {
                    -- Use VimTeX for building, so disable build-on-save here
                    onSave = false,
                  },
                  chktex = {
                    onOpenAndSave = true, -- Enable linter for common LaTeX errors
                  },
                },
              },
            })
          end,
        },
      })

      -- 3. Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover Info" })
      vim.keymap.set("n", "cd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename Variable" })
    end,
  },
}
