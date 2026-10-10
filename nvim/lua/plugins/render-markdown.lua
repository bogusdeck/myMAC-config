return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.nvim",
    },
    opts = {
      preset = "lazy",
      file_types = { "markdown", "markdown.mdx", "python", "javascript", "typescript", "lua", "go", "c", "cpp", "java", "rust" },
      render_modes = { "n" },
      change_events = { "InsertEnter", "InsertLeave" },
      anti_conceal = {
        enabled = false,
      },
      code = {
        highlight_inline = "String",
      },
      win_options = {
        conceallevel = {
          default = 0,
          rendered = 3,
        },
        concealcursor = {
          default = "",
          rendered = "",
        },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      pcall(function()
        require("render-markdown.core.colors").init()
        require("render-markdown.core.command").init()
        require("render-markdown.core.log").init()
        require("render-markdown.core.manager").init()
      end)
    end,
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle Markdown Render" },
      { "<leader>uM", "<cmd>RenderMarkdown buf_toggle<CR>", desc = "Toggle Markdown Render Buffer" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      for _, parser in ipairs({
        "markdown",
        "markdown_inline",
        "html",
        "yaml",
        "latex",
        "mermaid",
        "go",
        "python",
        "javascript",
        "typescript",
        "java",
        "c",
        "cpp",
      }) do
        if not vim.tbl_contains(opts.ensure_installed, parser) then
          table.insert(opts.ensure_installed, parser)
        end
      end
    end,
  },
}
