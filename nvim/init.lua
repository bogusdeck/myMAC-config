-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("custom.spotify")
require("custom.ai-toggle").setup()

-- Disable netrw's FileExplorer (opens on directory)
pcall(vim.api.nvim_del_augroup_by_name, "FileExplorer")

-- Enable AI suggestions by default (0 = disabled, 1 = enabled)
vim.g.ai_suggestions_enabled = 0
vim.g.ai_cmp = false  -- Use virtual text (ghost text) instead of cmp source

-- Toggle AI suggestions (Copilot + Codeium)
vim.keymap.set('n', '<leader>ai', '<cmd>AIToggle<CR>', { desc = 'Toggle AI suggestions', silent = true })
if vim.env.NVIM_CODEMAP ~= "1" then
  vim.cmd("autocmd VimEnter * Dashboard")
end

-- Disable auto format on save
vim.g.autoformat = false



-- Move current line or selection up/down using Leader key
-- Press Space + k to move up, Space + j to move down
vim.keymap.set('n', '<leader>k', ':mcao<CR>gv=gv', { silent = true })
vim.keymap.set('n', '<leader>j', ':mca+2<CR>gv=gv', { silent = true })
vim.keymap.set('v', '<leader>k', ':m\'< -2<CR>gv=gv', { silent = true })
vim.keymap.set('v', '<leader>j', ':m\'> +2<CR>gv=gv', { silent = true })

-- Set filetype for django templates
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.html", "*.htm"},
  callback = function()
    vim.bo.filetype = "htmldjango"
  end,
})
