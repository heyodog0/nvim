-- Task timestamp colors
vim.api.nvim_set_hl(0, "NeorgStarted",  { fg = "#e5c07b" })
vim.api.nvim_set_hl(0, "NeorgEnded",    { fg = "#98c379" })
vim.api.nvim_set_hl(0, "NeorgDuration", { fg = "#61afef" })

-- Custom cycle: ( ) → (-) → (x) → ( )
local task_cycle = { [" "] = "-", ["-"] = "x", ["x"] = " " }

local function cycle_task_state()
  local buf = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1]
  local state = line:match("^%s*%-%s+%((.-)%)")
  if not state or not task_cycle[state] then return false end
  local new_line = line:gsub("%((.-)%)", "(" .. task_cycle[state] .. ")", 1)
  vim.api.nvim_buf_set_lines(buf, row - 1, row, false, { new_line })
  return true
end

local function get_sub_lines(buf, row, task_indent)
  local total = vim.api.nvim_buf_line_count(buf)
  local sub_lines, sub_end = {}, row
  for i = row, math.min(row + 30, total - 1) do
    local l = vim.api.nvim_buf_get_lines(buf, i, i + 1, false)[1]
    if not l or l:match("^%s*$") then break end
    if #(l:match("^(%s*)") or "") > #task_indent then
      table.insert(sub_lines, { row = i, text = l })
      sub_end = i + 1
    else
      break
    end
  end
  return sub_lines, sub_end
end

local function handle_task_timestamp()
  local buf = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1]
  local state = line:match("^%s*%-%s+%((.-)%)")
  if not state then return end

  local task_indent = line:match("^(%s*)") or ""
  local sub_indent = task_indent .. "  "
  local timestamp = os.date("%b %d %H:%M")
  local sub_lines, sub_end = get_sub_lines(buf, row, task_indent)

  if state == "-" then
    for _, sl in ipairs(sub_lines) do
      if sl.text:match("Started:") then return end
    end
    vim.api.nvim_buf_set_lines(buf, row, row, false, { sub_indent .. "- Started: " .. timestamp })

  elseif state == "x" then
    for _, sl in ipairs(sub_lines) do
      if sl.text:match("Ended:") then return end
    end
    local started_ts = nil
    for _, sl in ipairs(sub_lines) do
      local ts = sl.text:match("Started:%s*(.-)%s*$")
      if ts then started_ts = ts; break end
    end
    local new_lines = { sub_indent .. "- Ended: " .. timestamp }
    if started_ts then
      local mon_names = { Jan=1,Feb=2,Mar=3,Apr=4,May=5,Jun=6,Jul=7,Aug=8,Sep=9,Oct=10,Nov=11,Dec=12 }
      local mon_str, day, hour, min = started_ts:match("(%a+)%s+(%d+)%s+(%d+):(%d+)")
      if mon_str and mon_names[mon_str] then
        local now = os.date("*t")
        local s = os.time({ year=now.year, month=mon_names[mon_str], day=tonumber(day), hour=tonumber(hour), min=tonumber(min), sec=0 })
        local diff = os.time() - s
        if diff > 0 then
          local h = math.floor(diff / 3600)
          local m = math.floor((diff % 3600) / 60)
          table.insert(new_lines, sub_indent .. "- Duration: " .. (h > 0 and (h .. "h ") or "") .. m .. "m")
        end
      end
    end
    vim.api.nvim_buf_set_lines(buf, sub_end, sub_end, false, new_lines)
  end
end

local function task_range(buf, row)
  local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1]
  local task_indent = line:match("^(%s*)") or ""
  local _, sub_end = get_sub_lines(buf, row, task_indent)
  return row, sub_end
end

local function archive_completed_tasks()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  local tasks = {}
  local i = 1
  while i <= #lines do
    if lines[i]:match("^%s*%-%s+%(x%)") then
      local task_indent = lines[i]:match("^(%s*)") or ""
      local task_lines = { lines[i] }
      local j = i + 1
      while j <= #lines do
        local nl = lines[j]
        if nl:match("^%s*$") then break end
        if #(nl:match("^(%s*)") or "") > #task_indent then
          table.insert(task_lines, nl)
          j = j + 1
        else
          break
        end
      end
      table.insert(tasks, { start = i, stop = j, lines = task_lines })
      i = j
    else
      i = i + 1
    end
  end

  if #tasks == 0 then
    vim.notify("No completed tasks to archive", vim.log.levels.INFO)
    return
  end

  for k = #tasks, 1, -1 do
    local t = tasks[k]
    vim.api.nvim_buf_set_lines(buf, t.start - 1, t.stop - 1, false, {})
  end

  lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local archive_row = nil
  for idx, l in ipairs(lines) do
    if l:match("^%*%s+Archive") then archive_row = idx; break end
  end

  local flat = {}
  for _, t in ipairs(tasks) do
    for _, tl in ipairs(t.lines) do table.insert(flat, tl) end
  end

  if archive_row then
    vim.api.nvim_buf_set_lines(buf, archive_row, archive_row, false, flat)
  else
    local footer = { "", "* Archive", "" }
    for _, l in ipairs(flat) do table.insert(footer, l) end
    vim.api.nvim_buf_set_lines(buf, #lines, #lines, false, footer)
  end

  vim.notify("Archived " .. #tasks .. " task(s)", vim.log.levels.INFO)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "norg",
  callback = function()
    vim.fn.matchadd("NeorgStarted",  "- Started:.*")
    vim.fn.matchadd("NeorgEnded",    "- Ended:.*")
    vim.fn.matchadd("NeorgDuration", "- Duration:.*")

    vim.keymap.set("n", "<CR>", function()
      if cycle_task_state() then vim.schedule(handle_task_timestamp) end
    end, { buffer = true })

    vim.keymap.set("n", "dd", function()
      local buf = vim.api.nvim_get_current_buf()
      local row = vim.api.nvim_win_get_cursor(0)[1]
      local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1]
      if line:match("^%s*%-%s+%((.-)%)") then
        local start_row, stop_row = task_range(buf, row)
        vim.api.nvim_buf_set_lines(buf, start_row - 1, stop_row, false, {})
      else
        vim.cmd("normal! dd")
      end
    end, { buffer = true })

    vim.keymap.set("n", "<leader>na", archive_completed_tasks,      { buffer = true, desc = "Archive completed tasks" })
    vim.keymap.set("n", "<leader>nt", "o- ( ) <Esc>A",              { buffer = true, desc = "New task" })
  end,
})

return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = { notes = "~/notes" },
            default_workspace = "notes",
          },
        },
      },
    },
  },
}
