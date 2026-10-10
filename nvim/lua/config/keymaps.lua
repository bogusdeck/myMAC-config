-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Navigate between tabs using Bufferline
local function next_buffer()
  if vim.fn.exists(":BufferLineCycleNext") == 2 then
    vim.cmd.BufferLineCycleNext()
  else
    vim.cmd.bnext()
  end
end

local function prev_buffer()
  if vim.fn.exists(":BufferLineCyclePrev") == 2 then
    vim.cmd.BufferLineCyclePrev()
  else
    vim.cmd.bprevious()
  end
end

local function term_next_buffer()
  vim.cmd.stopinsert()
  next_buffer()
end

local function term_prev_buffer()
  vim.cmd.stopinsert()
  prev_buffer()
end

vim.keymap.set({ "n", "i", "v", "s" }, "<A-Tab>", next_buffer, { desc = "Next Tab", silent = true })
vim.keymap.set({ "n", "i", "v", "s" }, "<M-Tab>", next_buffer, { desc = "Next Tab", silent = true })
vim.keymap.set({ "n", "i", "v", "s" }, "<Esc><Tab>", next_buffer, { desc = "Next Tab", silent = true })
vim.keymap.set("t", "<A-Tab>", term_next_buffer, { desc = "Next Tab", silent = true })
vim.keymap.set("t", "<M-Tab>", term_next_buffer, { desc = "Next Tab", silent = true })
vim.keymap.set("t", "<Esc><Tab>", term_next_buffer, { desc = "Next Tab", silent = true })

vim.keymap.set({ "n", "i", "v", "s" }, "<A-S-Tab>", prev_buffer, { desc = "Previous Tab", silent = true })
vim.keymap.set({ "n", "i", "v", "s" }, "<M-S-Tab>", prev_buffer, { desc = "Previous Tab", silent = true })
vim.keymap.set({ "n", "i", "v", "s" }, "<S-Tab>", prev_buffer, { desc = "Previous Tab", silent = true })
vim.keymap.set({ "n", "i", "v", "s" }, "<Esc><S-Tab>", prev_buffer, { desc = "Previous Tab", silent = true })
vim.keymap.set({ "n", "i", "v", "s" }, "<Esc>[Z", prev_buffer, { desc = "Previous Tab", silent = true })
vim.keymap.set("t", "<A-S-Tab>", term_prev_buffer, { desc = "Previous Tab", silent = true })
vim.keymap.set("t", "<M-S-Tab>", term_prev_buffer, { desc = "Previous Tab", silent = true })
vim.keymap.set("t", "<S-Tab>", term_prev_buffer, { desc = "Previous Tab", silent = true })
vim.keymap.set("t", "<Esc><S-Tab>", term_prev_buffer, { desc = "Previous Tab", silent = true })
vim.keymap.set("t", "<Esc>[Z", term_prev_buffer, { desc = "Previous Tab", silent = true })

-- Move buffers left/right
vim.keymap.set("n", "<leader>bp", ":BufferLineMovePrev<CR>", { desc = "Move buffer left" })
vim.keymap.set("n", "<leader>bn", ":BufferLineMoveNext<CR>", { desc = "Move buffer right" })

-- VS Code-like new tab and close tab
vim.keymap.set("n", "<D-t>", ":tabnew<CR>", { desc = "New Tab", noremap = true, silent = true })
vim.keymap.set("n", "<D-w>", ":bdelete<CR>", { desc = "Close Buffer", noremap = true, silent = true })
vim.keymap.set("n", "<C-w>", ":bdelete<CR>", { desc = "Close Buffer", noremap = true, silent = true })

-- VS Code-like tab management with Ctrl+Shift+Tab for history navigation
vim.keymap.set("n", "<C-Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Tab", noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous Tab", noremap = true, silent = true })

-- Pin/unpin buffer (VS Code-like)
vim.keymap.set("n", "<leader>tp", "<cmd>BufferLineTogglePin<CR>", { desc = "Pin Buffer", noremap = true, silent = true })
vim.keymap.set("n", "<leader>to", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close Other Buffers", noremap = true, silent = true })

-- Navigate buffers like VS Code (Ctrl+Tab for most recently used)
vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineMoveNext<CR>", { desc = "Move Buffer Next", noremap = true, silent = true })
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineMovePrev<CR>", { desc = "Move Buffer Previous", noremap = true, silent = true })

-- Numbered tab navigation (like VS Code with Cmd+1-9)
vim.keymap.set("n", "<D-1>", "1gt", { desc = "Go to tab 1", noremap = true })
vim.keymap.set("n", "<D-2>", "2gt", { desc = "Go to tab 2", noremap = true })
vim.keymap.set("n", "<D-3>", "3gt", { desc = "Go to tab 3", noremap = true })
vim.keymap.set("n", "<D-4>", "4gt", { desc = "Go to tab 4", noremap = true })
vim.keymap.set("n", "<D-5>", "5gt", { desc = "Go to tab 5", noremap = true })
vim.keymap.set("n", "<D-6>", "6gt", { desc = "Go to tab 6", noremap = true })
vim.keymap.set("n", "<D-7>", "7gt", { desc = "Go to tab 7", noremap = true })
vim.keymap.set("n", "<D-8>", "8gt", { desc = "Go to tab 8", noremap = true })
vim.keymap.set("n", "<D-9>", "9gt", { desc = "Go to tab 9", noremap = true })

--  Select All (Like Ctrl+A in VS Code)
vim.keymap.set("n", "<D-a>", "ggVG", { desc = "Select all", noremap = true, silent = true })

--  Copy Current Line Below (Like Shift+Alt+↓ in VS Code)
vim.keymap.set("n", "<S-A-j>", "yyp", { desc = "Copy line below", noremap = true, silent = true })

--  Copy Current Line Above (Like Shift+Alt+↑ in VS Code)
vim.keymap.set("n", "<S-A-k>", "yyP", { desc = "Copy line above", noremap = true, silent = true })

--  Move Line Down (Like Alt+↓ in VS Code)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", noremap = true, silent = true })

--  Move Line Up (Like Alt+↑ in VS Code)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", noremap = true, silent = true })

-- Move word forward with Option+Right Arrow
vim.keymap.set("n", "<A-Right>", "w", { desc = "Move word forward", noremap = true, silent = true })
vim.keymap.set("i", "<A-Right>", "<C-o>w", { desc = "Move word forward", noremap = true, silent = true })
vim.keymap.set("v", "<A-Right>", "w", { desc = "Move word forward", noremap = true, silent = true })

-- Move word backward with Option+Left Arrow
vim.keymap.set("n", "<A-Left>", "b", { desc = "Move word backward", noremap = true, silent = true })
vim.keymap.set("i", "<A-Left>", "<C-o>b", { desc = "Move word backward", noremap = true, silent = true })
vim.keymap.set("v", "<A-Left>", "b", { desc = "Move word backward", noremap = true, silent = true })

-- Search in current file with Cmd+F
vim.keymap.set("n", "<D-f>", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in file", noremap = true, silent = true })
vim.keymap.set("v", "<D-f>", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in file", noremap = true, silent = true })

-- Global search in project with Cmd+Shift+F
vim.keymap.set("n", "<D-F>", function()
  require("grug-far").open({ transient = true })
end, { desc = "Search in project (Grug-far)", noremap = true, silent = true })

vim.keymap.set("v", "<D-F>", function()
  require("grug-far").with_visual_selection({ transient = true })
end, { desc = "Search in project (Grug-far)", noremap = true, silent = true })


vim.keymap.set("n", "<leader>ua", function()
  require("custom.ai-toggle").toggle()
end, { desc = "Toggle AI Suggestions" })

vim.keymap.set("n", "<leader>ll", "<cmd>Leet<CR>", { desc = "Open LeetCode" })
vim.keymap.set("n", "<leader>lr", "<cmd>Leet run<CR>", { desc = "LeetCode Run" })
vim.keymap.set("n", "<leader>lL", "<cmd>Leet lang<CR>", { desc = "LeetCode Language" })
vim.keymap.set("n", "<leader>ls", "<cmd>Leet submit<CR>", { desc = "LeetCode Submit" })

-- VS Code-like tab navigation (Ctrl+Tab / Ctrl+Shift+Tab)
vim.keymap.set("n", "<C-Tab>", next_buffer, { desc = "Next Tab", noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Tab>", prev_buffer, { desc = "Previous Tab", noremap = true, silent = true })

-- Option+Tab tab navigation (macOS Kitty style)
vim.keymap.set("n", "<A-Tab>", next_buffer, { desc = "Next Tab", noremap = true, silent = true })
vim.keymap.set("n", "<A-S-Tab>", prev_buffer, { desc = "Previous Tab", noremap = true, silent = true })
vim.keymap.set("n", "<D-1>", "1gt", { desc = "Go to tab 1", noremap = true })
vim.keymap.set("n", "<D-2>", "2gt", { desc = "Go to tab 2", noremap = true })
vim.keymap.set("n", "<D-3>", "3gt", { desc = "Go to tab 3", noremap = true })
vim.keymap.set("n", "<D-4>", "4gt", { desc = "Go to tab 4", noremap = true })
vim.keymap.set("n", "<D-5>", "5gt", { desc = "Go to tab 5", noremap = true })
vim.keymap.set("n", "<D-6>", "6gt", { desc = "Go to tab 6", noremap = true })
vim.keymap.set("n", "<D-7>", "7gt", { desc = "Go to tab 7", noremap = true })
vim.keymap.set("n", "<D-8>", "8gt", { desc = "Go to tab 8", noremap = true })
vim.keymap.set("n", "<D-9>", "9gt", { desc = "Go to tab 9", noremap = true })

-- VS Code-like additional keybindings
-- Quick open (Cmd+P equivalent) - already have <leader>fp
-- Toggle sidebar
vim.keymap.set("n", "<D-e>", "<cmd>lua Snacks.explorer().toggle()<CR>", { desc = "Toggle Explorer", noremap = true, silent = true })

-- Better line navigation like VS Code
vim.keymap.set("n", "<C-a>", "^", { desc = "Start of line", noremap = true })
vim.keymap.set("n", "<C-e>", "$", { desc = "End of line", noremap = true })

-- Window navigation (VS Code uses Ctrl+Alt+Arrow)
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Go to left window", noremap = true })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Go to right window", noremap = true })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Go to upper window", noremap = true })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Go to lower window", noremap = true })

-- VS Code-like multi-cursor (Alt+Click not directly possible but add visual block)
-- Split view navigation
vim.keymap.set("n", "<C-S-Left>", "<C-w>H", { desc = "Move window left", noremap = true })
vim.keymap.set("n", "<C-S-Right>", "<C-w>L", { desc = "Move window right", noremap = true })

-- Comment line (VS Code: Cmd+/) - LazyVim already has this
-- Format document (VS Code: Shift+Alt+F)
vim.keymap.set("n", "<S-A-F>", vim.lsp.buf.format, { desc = "Format document", noremap = true, silent = true })

-- Rename symbol (VS Code: F2)
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol", noremap = true, silent = true })

-- Go to definition (VS Code: F12)
vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, { desc = "Go to definition", noremap = true, silent = true })

-- Hover like VS Code (Ctrl+K Ctrl+I or K)
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation", noremap = true, silent = true })

-- Find references (VS Code: Shift+F12)
vim.keymap.set("n", "<S-F12>", vim.lsp.buf.references, { desc = "Find references", noremap = true, silent = true })

-- Show actions on line (VS Code: Cmd+. or Ctrl+.)
vim.keymap.set("n", "<D-.>", vim.diagnostic.open_float, { desc = "Show diagnostics", noremap = true, silent = true })
vim.keymap.set("n", "<C-.>", vim.diagnostic.open_float, { desc = "Show diagnostics", noremap = true, silent = true })

-- Safe & Workspace-Aware Git Pickers (supports single repos and multi-repo directories like ~/work)
local function get_git_root()
  local buf_dir = vim.fn.expand("%:p:h")
  if buf_dir ~= "" and vim.fn.isdirectory(buf_dir) == 1 then
    local out = vim.fn.system({ "git", "-C", buf_dir, "rev-parse", "--show-toplevel" })
    if vim.v.shell_error == 0 then
      return vim.trim(out)
    end
  end
  local cwd = vim.fn.getcwd()
  local out = vim.fn.system({ "git", "-C", cwd, "rev-parse", "--show-toplevel" })
  if vim.v.shell_error == 0 then
    return vim.trim(out)
  end
  return nil
end

local function scan_workspace_repos(base_dir)
  local repos = {}
  local handle = vim.loop.fs_scandir(base_dir)
  if handle then
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then break end
      if type == "directory" then
        local git_dir = base_dir .. "/" .. name .. "/.git"
        if vim.loop.fs_stat(git_dir) then
          table.insert(repos, { name = name, dir = base_dir .. "/" .. name })
        end
      end
    end
  end
  return repos
end

local function safe_git(picker_type)
  local root = get_git_root()

  -- Single repository mode (active file or CWD is inside a Git repo)
  if root then
    if picker_type == "status" then
      local status_out = vim.fn.system({ "git", "-C", root, "status", "--porcelain" })
      if status_out == "" or status_out == nil then
        vim.notify("Git working tree is clean (no modified files)", vim.log.levels.INFO, { title = "Git Status" })
        return
      end
      if package.loaded["snacks"] and _G.Snacks and _G.Snacks.picker then
        _G.Snacks.picker.git_status({ cwd = root })
      else
        vim.cmd("Telescope git_status cwd=" .. root)
      end
    elseif picker_type == "log" then
      if package.loaded["snacks"] and _G.Snacks and _G.Snacks.picker then
        _G.Snacks.picker.git_log({ cwd = root })
      else
        vim.cmd("Telescope git_commits cwd=" .. root)
      end
    elseif picker_type == "diff" then
      local status_out = vim.fn.system({ "git", "-C", root, "status", "--porcelain" })
      if status_out == "" or status_out == nil then
        vim.notify("Git working tree is clean (no diff available)", vim.log.levels.INFO, { title = "Git Diff" })
        return
      end
      if package.loaded["snacks"] and _G.Snacks and _G.Snacks.picker then
        _G.Snacks.picker.git_diff({ cwd = root })
      else
        vim.cmd("DiffviewOpen " .. root)
      end
    end
    return
  end

  -- Multi-repo Workspace mode (e.g. ~/work)
  local base_dir = vim.fn.getcwd()
  local repos = scan_workspace_repos(base_dir)
  if #repos == 0 and base_dir ~= vim.fn.expand("~/work") then
    base_dir = vim.fn.expand("~/work")
    repos = scan_workspace_repos(base_dir)
  end

  if #repos == 0 then
    vim.notify("Not inside a Git repository or multi-repo workspace", vim.log.levels.WARN, { title = "Git" })
    return
  end

  if picker_type == "status" or picker_type == "diff" then
    local items = {}
    for _, repo in ipairs(repos) do
      local status_out = vim.fn.system({ "git", "-C", repo.dir, "status", "--porcelain" })
      if status_out and status_out ~= "" then
        for line in status_out:gmatch("[^\r\n]+") do
          local st = line:sub(1, 2)
          local file = line:sub(4)
          local full_path = repo.dir .. "/" .. file
          table.insert(items, {
            cwd = repo.dir,
            file = file,
            full_path = full_path,
            text = st .. "  [" .. repo.name .. "] " .. file,
            repo = repo.name,
            status = st,
          })
        end
      end
    end

    if #items == 0 then
      vim.notify("Workspace working tree is clean across all repositories", vim.log.levels.INFO, { title = "Workspace Git" })
      return
    end

    if package.loaded["snacks"] and _G.Snacks and _G.Snacks.picker then
      _G.Snacks.picker({
        title = "Workspace Git (" .. #items .. " modified files across " .. #repos .. " repos)",
        items = items,
        preview = "git_status",
        format = "file",
        confirm = function(picker, item)
          picker:close()
          if item then
            local target_path = item.full_path or (item.cwd and item.file and (item.cwd .. "/" .. item.file)) or item.file
            if target_path then
              vim.cmd("edit " .. vim.fn.fnameescape(target_path))
            end
          end
        end,
      })
    else
      vim.notify("Found " .. #items .. " modified files in workspace", vim.log.levels.INFO, { title = "Workspace Git" })
    end
  elseif picker_type == "log" then
    if package.loaded["snacks"] and _G.Snacks and _G.Snacks.picker then
      local log_items = {}
      for _, repo in ipairs(repos) do
        local log_out = vim.fn.system({ "git", "-C", repo.dir, "log", "-n", "10", "--oneline" })
        if log_out and log_out ~= "" then
          for line in log_out:gmatch("[^\r\n]+") do
            table.insert(log_items, {
              text = "[" .. repo.name .. "] " .. line,
              repo = repo.name,
            })
          end
        end
      end
      _G.Snacks.picker({
        title = "Workspace Recent Commits",
        items = log_items,
      })
    end
  end
end

vim.keymap.set("n", "<leader>gs", function() safe_git("status") end, { desc = "Git Status (Safe)", noremap = true, silent = true })
vim.keymap.set("n", "<leader>gl", function() safe_git("log") end, { desc = "Git Log (Safe)", noremap = true, silent = true })
vim.keymap.set("n", "<leader>gd", function() safe_git("diff") end, { desc = "Git Diff (Safe)", noremap = true, silent = true })

-- Toggle inline diagnostic virtual text (keep gutter signs)
vim.keymap.set("n", "<leader>uv", function()
  local config = vim.diagnostic.config()
  vim.diagnostic.config({ virtual_text = not config.virtual_text })
end, { desc = "Toggle Diagnostic Virtual Text", noremap = true, silent = true })
