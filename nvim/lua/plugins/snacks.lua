return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>n", false },
      {
        "<leader>m",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      -- VS Code-like explorer toggle (<C+S+E>)
      {
        "<leader>e",
        function()
          Snacks.explorer({ cwd = vim.fn.getcwd() })
        end,
        desc = "Explorer (VSCode-like)",
        remap = true,
      },
    },
    opts = {
      dashboard = {
        enabled = false,
      },
      picker = {
        -- Default layout preset for search modals (find files, grep, word search, etc.)
        layout = {
          preset = "fullscreen_modal",
        },
        layouts = {
          fullscreen_modal = {
            layout = {
              box = "horizontal",
              width = 0.98,
              height = 0.98,
              {
                box = "vertical",
                border = true,
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", width = 0.60, border = true },
            },
          },
          git_37_modal = {
            layout = {
              box = "horizontal",
              width = 0.98,
              height = 0.98,
              {
                box = "vertical",
                border = true,
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", width = 0.70, border = true }, -- 3:7 Ratio
            },
          },
        },
        sources = {
          -- File Explorer remains strictly in Sidebar mode
          explorer = {
            layout = {
              preset = "sidebar",
              preview = false,
              layout = {
                width = 32,
                min_width = 30,
              },
            },
          },
          git_log = {
            layout = {
              preset = "git_37_modal",
            },
            format = function(item, picker)
              local a = Snacks.picker.util.align
              local c = (item.commit or item.branch or "HEAD"):sub(1, 7)
              local d = item.date or ""
              local msg = item.msg or item.text or ""
              msg = msg:gsub("%s*<.*>$", "")

              return {
                { "  " .. a(c, 8), "SnacksPickerGitCommit" },
                { "  " .. a(d, 16), "SnacksPickerGitDate" },
                { "\n     ", "Normal" },
                { msg, "SnacksPickerGitMsg" },
              }
            end,
          },
          git_status = {
            layout = {
              preset = "git_37_modal",
            },
          },
        },
        icons = {
          kinds = {
            Collapsed = " ",
          },
        },
      },
      explorer = {
        enabled = true,
        replace_netrw = true,
      },
    },
  },
}
