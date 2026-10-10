return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
      require("transparent").setup({
        -- table: default groups
        groups = {
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
          'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
          'SignColumn', 'CursorLine', 'CursorLineNr',
          'EndOfBuffer',
        },
        -- table: additional groups that should be cleared
        extra_groups = {
          "NormalFloat",     -- plugins which have float panel such as Lazy, Mason, LspInfo
          "NvimTreeNormal",  -- NvimTree
          "NeoTreeNormal",
          "NeoTreeNormalNC",
          "SnacksPickerNormal",
          "SnacksPickerList",
          "SnacksPickerPreview",
          "TelescopeNormal",
          "TelescopeBorder",
          "TelescopePromptBorder",
          "TelescopeResultsBorder",
          "TelescopePreviewBorder",
          "TelescopePromptNormal",
          "TelescopeResultsNormal",
          "TelescopePreviewNormal",
          "WhichKeyFloat",
        },
        -- table: groups you don't want to clear
        exclude_groups = {
          "lualine_a_normal",
          "lualine_b_normal",
          "lualine_c_normal",
          "lualine_a_insert",
          "lualine_b_insert",
          "lualine_c_insert",
          "lualine_a_visual",
          "lualine_b_visual",
          "lualine_c_visual",
          "lualine_a_command",
          "lualine_b_command",
          "lualine_c_command",
        },
      })
    end,
  }
}
