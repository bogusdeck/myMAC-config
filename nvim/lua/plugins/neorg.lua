return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      vim.opt.runtimepath:append(vim.fn.expand("~/.local/share/nvim/lazy-rocks/tree-sitter-norg/lib/lua/5.1"))
      vim.opt.runtimepath:append(vim.fn.expand("~/.local/share/nvim/lazy-rocks/tree-sitter-norg-meta/lib/lua/5.1"))
      vim.opt.runtimepath:append(vim.fn.expand("~/.local/share/nvim/site"))
    end,
    keys = {
      { "<leader>nn", "<Plug>(neorg.dirman.new-note)", desc = "Neorg New Note" },
      { "<leader>ni", "<cmd>Neorg index<CR>", desc = "Neorg Index" },
      { "<leader>nj", "<cmd>Neorg journal today<CR>", desc = "Neorg Journal Today" },
      { "<leader>nr", "<cmd>Neorg return<CR>", desc = "Neorg Return" },
      { "<leader>nw", "<cmd>Neorg workspace notes<CR>", desc = "Neorg Notes Workspace" },
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = vim.fn.expand("~/notes/neorg"),
            },
            default_workspace = "notes",
          },
        },
      },
    },
  },
}
