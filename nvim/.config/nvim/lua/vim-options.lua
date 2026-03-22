-- GENERAL
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

vim.cmd("set number")


-- Copy/Paste with clipboard
vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("i", "<C-v>", '"+p')



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
