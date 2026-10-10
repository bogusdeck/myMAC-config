return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    local toggleterm = require("toggleterm")
    local terms = require("toggleterm.terminal")
    local Terminal = terms.Terminal

    -- Track if the user wants single active maximized terminal view
    local is_maximized = false

    local function maximize_current_win()
      local win = vim.api.nvim_get_current_win()
      if vim.api.nvim_win_is_valid(win) then
        vim.cmd("wincmd _")
      end
    end

    -- Toggle maximize/minimize on active terminal split
    local function toggle_maximize_terminal(term_win)
      local win = term_win or vim.api.nvim_get_current_win()
      if not vim.api.nvim_win_is_valid(win) then return end
      vim.api.nvim_set_current_win(win)

      if is_maximized then
        vim.cmd("wincmd =")
        is_maximized = false
      else
        vim.cmd("wincmd _")
        is_maximized = true
      end
    end

    -- Get all open vertical sidebar terminal windows sorted by vertical position (top to bottom)
    local function get_open_terminal_windows()
      local wins = {}
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_is_valid(win) then
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          local bt = vim.bo[buf].buftype
          if ft == "toggleterm" or bt == "terminal" then
            -- Exclude floating popups
            if vim.fn.win_gettype(win) ~= "popup" then
              local pos = vim.api.nvim_win_get_position(win)
              table.insert(wins, { win = win, buf = buf, row = pos[1], col = pos[2] })
            end
          end
        end
      end
      -- Sort top-most first (row ascending)
      table.sort(wins, function(a, b) return a.row < b.row end)
      return wins
    end

    toggleterm.setup({
      size = function(term)
        if term.direction == "horizontal" then
          return math.floor(vim.o.lines * 0.35)
        elseif term.direction == "vertical" then
          return math.min(math.floor(vim.o.columns * 0.35), 65)
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = false, -- Start in normal mode, enter insert only with 'i' or 'a'
      insert_mappings = false,
      terminal_mappings = false,
      persist_size = false,
      persist_mode = false,
      direction = "vertical",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 3,
        width = function()
          return math.floor(vim.o.columns * 0.96)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.96)
        end,
      },
      on_open = function(term)
        -- Double click inside this terminal toggles maximize (minimizes others) / restore
        vim.keymap.set({ "n", "t" }, "<2-LeftMouse>", function()
          toggle_maximize_terminal(term.window)
        end, { buffer = term.bufnr, silent = true, desc = "Double Click: Maximize/Minimize Terminal" })

        -- When clicking on a terminal while in maximized mode, maximize the clicked terminal
        vim.keymap.set({ "n", "t" }, "<LeftMouse>", function()
          local mouse = vim.fn.getmousepos()
          if mouse and mouse.winid > 0 and vim.api.nvim_win_is_valid(mouse.winid) then
            vim.api.nvim_set_current_win(mouse.winid)
            if is_maximized then
              maximize_current_win()
            end
          end
        end, { buffer = term.bufnr, silent = true })
      end,
    })

    -- Focus terminal strictly by position on screen (1 = top, 2 = next below, etc.)
    -- If position doesn't exist yet (e.g. 2 open and user presses Option+3), create the new terminal!
    local function focus_terminal_by_pos(target_index)
      local open_wins = get_open_terminal_windows()

      if open_wins[target_index] then
        -- Terminal at this position exists: focus it!
        vim.api.nvim_set_current_win(open_wins[target_index].win)
        if is_maximized then
          maximize_current_win()
        end
      else
        -- Terminal at this position does NOT exist yet: create it!
        local new_id = #open_wins + 1
        toggleterm.toggle(new_id, nil, nil, "vertical")
        vim.defer_fn(function()
          local updated_wins = get_open_terminal_windows()
          if updated_wins[target_index] then
            vim.api.nvim_set_current_win(updated_wins[target_index].win)
          elseif #updated_wins > 0 then
            vim.api.nvim_set_current_win(updated_wins[#updated_wins].win)
          end
          if is_maximized then
            maximize_current_win()
          end
        end, 60)
      end
    end

    -- Option + 1..9 mappings
    local mac_opt_keys = { "¡", "™", "£", "¢", "∞", "§", "¶", "•", "ª" }
    for i = 1, 9 do
      -- In Normal mode: support Alt, Meta, and macOS raw character codes
      vim.keymap.set("n", "<A-" .. i .. ">", function() focus_terminal_by_pos(i) end, { desc = "Focus Terminal " .. i, silent = true })
      vim.keymap.set("n", "<M-" .. i .. ">", function() focus_terminal_by_pos(i) end, { desc = "Focus Terminal " .. i, silent = true })
      vim.keymap.set("n", mac_opt_keys[i], function() focus_terminal_by_pos(i) end, { desc = "Focus Terminal " .. i, silent = true })

      -- In Terminal mode: map only clean Alt/Meta combinations (never map Escape prefixes)
      vim.keymap.set("t", "<A-" .. i .. ">", function() focus_terminal_by_pos(i) end, { desc = "Focus Terminal " .. i, silent = true })
      vim.keymap.set("t", "<M-" .. i .. ">", function() focus_terminal_by_pos(i) end, { desc = "Focus Terminal " .. i, silent = true })
    end

    -- Add New Sidebar Terminal
    local function open_new_sidebar_terminal()
      local open_wins = get_open_terminal_windows()
      local next_id = #open_wins + 1
      focus_terminal_by_pos(next_id)
    end

    vim.keymap.set({ "n", "t" }, "<leader>ts", function() focus_terminal_by_pos(1) end, { desc = "Toggle Right Sidebar Terminal" })
    vim.keymap.set({ "n", "t" }, "<leader>tt", function() focus_terminal_by_pos(1) end, { desc = "Toggle Right Sidebar Terminal" })
    vim.keymap.set("n", "<leader>tn", open_new_sidebar_terminal, { desc = "Add New Terminal in Sidebar" })
    vim.keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", { desc = "Toggle All Terminals" })
    vim.keymap.set({ "n", "t" }, "<leader>tz", function() toggle_maximize_terminal() end, { desc = "Toggle Maximize/Minimize Terminal" })



    -- 3. Horizontal Terminal (Dedicated ID 97)
    local horiz_term = Terminal:new({ id = 97, count = 97, direction = "horizontal", hidden = true })
    vim.keymap.set("n", "<leader>th", function() horiz_term:toggle() end, { desc = "Toggle Horizontal Terminal (Bottom)" })

    -- 4. LazyGit (FullScreen Float, Dedicated ID 99)
    local lazygit = Terminal:new({
      id = 99,
      count = 99,
      cmd = "lazygit",
      direction = "float",
      hidden = true,
      float_opts = {
        width = function() return math.floor(vim.o.columns * 0.96) end,
        height = function() return math.floor(vim.o.lines * 0.96) end,
      },
    })

    local function open_lazygit()
      local out = vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
      if vim.v.shell_error ~= 0 or not out:match("true") then
        vim.notify("Not inside a Git repository", vim.log.levels.WARN, { title = "LazyGit" })
        return
      end
      lazygit:toggle()
    end

    vim.keymap.set("n", "<leader>tg", open_lazygit, { desc = "Toggle LazyGit (FullScreen)" })
    vim.keymap.set("n", "<leader>gg", open_lazygit, { desc = "Toggle LazyGit (FullScreen)" })

    -- Window navigation out of terminal with <C-h/j/k/l>
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Move to Left Window" })
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Move to Right Window" })
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Move to Lower Window" })
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Move to Upper Window" })
  end,
}