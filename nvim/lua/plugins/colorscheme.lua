return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      term_colors = true,
      transparent_background = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = { "italic" },
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
      },
      color_overrides = {
        mocha = {
          base = "#040a0c",
          mantle = "#061115",
          crust = "#78D6C6",
          subtext1 = "#bac2de",
          subtext0 = "#a6adc8",
          overlay2 = "#008170",
          overlay1 = "#04364A",
          overlay0 = "#419197",
          surface2 = "#2D9596",
          surface1 = "#176B87",
          surface0 = "#265073",
        },
      },
      integrations = {
        telescope = {
          enabled = true,
          style = "lazyvim",
        },
        dropbar = {
          enabled = true,
          color_mode = true,
        },
        barbecue = {
          dim_dirname = true,
          bold_basename1 = true,
          dim_context = false,
          alt_background = false,
        },
        dashboard = {
          enabled = true,
          color_mode = true,
        },
        which_key = true,
        notify = true,
        lualine = {
          theme = "catppuccin",
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin-mocha")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}




