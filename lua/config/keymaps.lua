local function toggle_terminal()
  local term_buf = nil
  local term_win = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
      term_buf = buf
      break
    end
  end
  if term_buf then
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == term_buf then
        term_win = win
        break
      end
    end
    if term_win then
      vim.api.nvim_win_close(term_win, false)
    else
      vim.cmd("belowright split")
      vim.api.nvim_buf_set_option(term_buf, "buflisted", true)
      vim.api.nvim_win_set_buf(0, term_buf)
      vim.cmd("startinsert")
    end
  else
    vim.cmd("belowright split | terminal")
    vim.cmd("startinsert")
  end
end

local function open_in_finder()
  local path = nil
  if vim.bo.filetype == "NvimTree" then
    local ok, api = pcall(require, "nvim-tree.api")
    if ok then
      local node = api.tree.get_node_under_cursor()
      if node then path = node.absolute_path or node.link_to end
    end
  else
    path = vim.fn.expand("%:p")
  end
  if not path or path == "" then
    vim.notify("No file selected to open", vim.log.levels.WARN)
    return
  end
  vim.fn.jobstart({ "open", path }, { detach = true })
end

-- File tree
vim.keymap.set("n", "<leader>n",  ":NvimTreeToggle<CR>",  { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>m",  ":NvimTreeFocus<CR>",   { desc = "Focus file tree" })

-- Telescope
vim.keymap.set("n", "<leader>t",  ":Telescope<CR>",                        { desc = "Open telescope" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>",         { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",          { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>",            { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",          { desc = "Find help" })

-- Splits
vim.keymap.set("n", "<leader>v",  ":vsplit<CR>",  { desc = "Vertical split" })
vim.keymap.set("n", "<leader>s",  ":split<CR>",   { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>q",  ":close<CR>",   { desc = "Close split" })
vim.keymap.set("n", "<leader>/",  "/",            { desc = "Search" })

-- Git
vim.keymap.set("n", "]c",          ":Gitsigns next_hunk<CR>",    { desc = "Next git change" })
vim.keymap.set("n", "[c",          ":Gitsigns prev_hunk<CR>",    { desc = "Previous git change" })
vim.keymap.set("n", "<leader>gp",  ":Gitsigns preview_hunk<CR>", { desc = "Preview git change" })
vim.keymap.set("n", "<leader>gb",  ":Gitsigns blame_line<CR>",   { desc = "Git blame" })

-- Buffers
vim.keymap.set("n", "<leader>bd",  ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bn",  ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bx",  ":bdelete!<CR>",            { desc = "Close buffer" })

-- Terminal
vim.keymap.set("n", "<leader>j",  toggle_terminal, { desc = "Toggle terminal" })
vim.keymap.set("t", "<leader>j",  toggle_terminal, { desc = "Toggle terminal from terminal mode" })

-- Runner
vim.keymap.set("n", "<leader>r",  ":belowright split | terminal uv run %<CR>i", { desc = "Run current file with uv" })
vim.keymap.set("n", "<leader>c",  ":belowright split | terminal cargo run<CR>i", { desc = "Run cargo project" })

-- Misc
vim.keymap.set("n", "<leader>o",  open_in_finder, { desc = "Open in Finder" })

-- Neorg
vim.keymap.set("n", "<leader>nw", "<cmd>Neorg workspace notes<cr>", { desc = "Open Neorg notes workspace" })
