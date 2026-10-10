return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          width = 0.96,
          height = 0.96,
          preview_width = 0.60, -- 60% of window width dedicated to git log / diff previews
        },
      },
    },
    pickers = {
      git_commits = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            width = 0.96,
            height = 0.96,
            preview_width = 0.65,
          },
        },
      },
      git_bcommits = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            width = 0.96,
            height = 0.96,
            preview_width = 0.65,
          },
        },
      },
      git_status = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            width = 0.96,
            height = 0.96,
            preview_width = 0.65,
          },
        },
      },
      git_branches = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            width = 0.96,
            height = 0.96,
            preview_width = 0.60,
          },
        },
      },
    },
  },
}
