-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Indentation & Tab Size (4 spaces for 1 tab)
vim.opt.tabstop = 4        -- A tab character displays as 4 spaces
vim.opt.shiftwidth = 4     -- Indentation level is 4 spaces
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.softtabstop = 4    -- Makes backspacing behave as expected

-- Line Separators (Unix & macOS: \n)
vim.opt.fileformat = "unix"      -- Set default fileformat to Unix (\n)
vim.opt.fileformats = "unix,dos" -- Prefer Unix line endings over Windows DOS (\r\n)

-- VS Code-like UI options
vim.opt.number = true          -- Show absolute line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.cursorline = true      -- Highlight current line
vim.opt.signcolumn = "yes"     -- Always show sign column
vim.opt.colorcolumn = "0"      -- No color column
vim.opt.wrap = false           -- No line wrapping
vim.opt.scrolloff = 8          -- Lines of context around cursor
vim.opt.sidescrolloff = 8      -- Vertical context

-- Optimize built-in diff mode for large vertical splits
vim.opt.diffopt = "internal,filler,closeoff,linematch:60,algorithm:histogram,vertical"

-- Font configuration (for GUI Neovim frontends like Neovide, Goneovim, etc.)
vim.opt.guifont = "Iosevka:h13"
