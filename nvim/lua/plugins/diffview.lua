return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
      {
        "<leader>gd",
        function()
          local out = vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
          if vim.v.shell_error ~= 0 or not out:match("true") then
            vim.notify("Not inside a Git repository", vim.log.levels.WARN, { title = "Git Diff" })
            return
          end
          vim.cmd("DiffviewOpen")
        end,
        desc = "Diffview Open (Full Diff)",
      },
      {
        "<leader>gh",
        function()
          local out = vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
          if vim.v.shell_error ~= 0 or not out:match("true") then
            vim.notify("Not inside a Git repository", vim.log.levels.WARN, { title = "Git History" })
            return
          end
          vim.cmd("DiffviewFileHistory %")
        end,
        desc = "File History (Current File)",
      },
      {
        "<leader>gH",
        function()
          local out = vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
          if vim.v.shell_error ~= 0 or not out:match("true") then
            vim.notify("Not inside a Git repository", vim.log.levels.WARN, { title = "Git History" })
            return
          end
          vim.cmd("DiffviewFileHistory")
        end,
        desc = "File History (Entire Repo)",
      },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    },
    opts = {
      enhanced_diff_hl = true,
      use_icons = true,
      view = {
        default = {
          layout = "diff2_horizontal",
          winbar_info = true,
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
        },
        file_history = {
          layout = "diff2_horizontal",
          winbar_info = true,
        },
      },
    },
  },
}
