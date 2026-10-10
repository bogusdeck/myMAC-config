return {
   "bogusdeck/codemap.nvim",
   lazy = false,
   config = function()
     require("codemap").setup({
       workspace = vim.fn.stdpath("data") .. "/codemap",
       run_timeout_ms = 5000,
       default_language = "python",
       keymaps = true,
     })
   end,
}
