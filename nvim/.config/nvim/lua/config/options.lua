local opt = vim.opt

-- Indentation
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- UI and Visibility
opt.number = true
opt.relativenumber = false -- Relative line numbers
opt.cursorline = true      -- Highlight current line
opt.scrolloff = 8          -- Minimum lines to keep above/below cursor
opt.signcolumn = "yes"     -- Always show sign column to prevent text shift
opt.termguicolors = true   -- Enable 24-bit true colors
opt.wrap = false           -- Disable line wrap
-- opt.cmdheight = 0         -- Hide command line when not in use


-- Smart Search
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true  -- Case-sensitive if uppercase is used
opt.incsearch = true  -- Highlight matches as you type
opt.hlsearch = false  -- Clear highlight after search

-- Windows and Operational Behavior
-- opt.splitbelow = true     -- Horizontal splits go below
-- opt.splitright = true     -- Vertical splits go right
opt.undofile = true -- Persistent undo across sessions




-- PDF OPENING
-- Intercept the opening of PDF files
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function(args)
    -- Launch Zathura in the background asynchronously (detach = true prevents blocking Neovim)
    vim.fn.jobstart({ "zathura", args.file }, { detach = true })

    -- Immediately close the PDF buffer before Neovim shows weird characters
    vim.api.nvim_buf_delete(args.buf, { force = true })
  end,
  desc = "Open PDFs with Zathura instead of reading them as text",
})

-- TEXT & LATEX SETTINGS
-- Enable soft wrap specifically for prose/text-heavy files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true -- Keep indent on visual wrap
  end,
})
