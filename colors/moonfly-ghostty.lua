-- Hybrid colorscheme: Moonfly text colors + Ghostty background
-- Keeps the ghostty dark background (#00031D) with moonfly's text color palette

local colors = {
  -- Ghostty background
  bg = "#00031D",

  -- Moonfly palette
  black = "#080808",
  white = "#c6c6c6",

  -- Greys
  grey0 = "#323437",
  grey1 = "#373c4d",
  grey7 = "#121212",
  grey13 = "#212121",
  grey23 = "#3a3a3a",
  grey27 = "#444444",
  grey50 = "#808080",
  grey62 = "#9e9e9e",
  grey70 = "#b2b2b2",
  grey89 = "#e4e4e4",

  -- Colors
  red = "#ff5d5d",
  crimson = "#ff5189",
  coral = "#f09479",
  orange = "#de935f",
  yellow = "#e3c78a",
  lime = "#85dc85",
  green = "#8cc85f",
  emerald = "#36c692",
  turquoise = "#79dac8",
  sky = "#74b2ff",
  blue = "#80a0ff",
  lavender = "#adadf3",
  violet = "#cf87e8",
  purple = "#ae81ff",
}

vim.g.colors_name = "moonfly-ghostty"

-- Reset highlighting
vim.cmd("hi clear")

-- Basic highlights
vim.api.nvim_set_hl(0, "Normal", { fg = colors.grey70, bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.grey70, bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.grey23, bg = "NONE" })

-- Cursor
vim.api.nvim_set_hl(0, "Cursor", { fg = colors.bg, bg = colors.grey62 })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#0a0a2e" })
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#0a0a2e" })

-- Selection
vim.api.nvim_set_hl(0, "Visual", { fg = colors.white, bg = colors.grey1 })
vim.api.nvim_set_hl(0, "VisualNOS", { fg = colors.white, bg = colors.grey1 })

-- Search
vim.api.nvim_set_hl(0, "Search", { fg = colors.black, bg = colors.yellow })
vim.api.nvim_set_hl(0, "IncSearch", { fg = colors.black, bg = colors.orange })

-- UI
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.grey23 })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.sky, bold = true })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#0a0a2e" })
vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.grey23 })

-- Status line
vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.grey70, bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.grey23, bg = "NONE" })

-- Messages
vim.api.nvim_set_hl(0, "MsgArea", { fg = colors.grey70 })
vim.api.nvim_set_hl(0, "MsgSeparator", { fg = colors.grey23, bg = "NONE" })

-- Syntax highlighting
vim.api.nvim_set_hl(0, "Comment", { fg = colors.grey50, italic = true })
vim.api.nvim_set_hl(0, "String", { fg = colors.lime })
vim.api.nvim_set_hl(0, "Number", { fg = colors.orange })
vim.api.nvim_set_hl(0, "Boolean", { fg = colors.orange })
vim.api.nvim_set_hl(0, "Identifier", { fg = colors.turquoise })
vim.api.nvim_set_hl(0, "Function", { fg = colors.sky })
vim.api.nvim_set_hl(0, "Keyword", { fg = colors.violet })
vim.api.nvim_set_hl(0, "Statement", { fg = colors.violet })
vim.api.nvim_set_hl(0, "Type", { fg = colors.sky })
vim.api.nvim_set_hl(0, "Operator", { fg = colors.turquoise })
vim.api.nvim_set_hl(0, "Special", { fg = colors.coral })
vim.api.nvim_set_hl(0, "Constant", { fg = colors.orange })
vim.api.nvim_set_hl(0, "PreProc", { fg = colors.violet })

-- Diagnostics
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.red })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.sky })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.blue })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = colors.red })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = colors.yellow })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = colors.sky })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, sp = colors.blue })

-- Tree-sitter
vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@function", { link = "Function" })
vim.api.nvim_set_hl(0, "@function.call", { link = "Function" })
vim.api.nvim_set_hl(0, "@keyword", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@string", { link = "String" })
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
vim.api.nvim_set_hl(0, "@type", { link = "Type" })
vim.api.nvim_set_hl(0, "@number", { link = "Number" })
vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })

-- Diff
vim.api.nvim_set_hl(0, "DiffAdd", { fg = colors.green, bg = "#0a2a0a" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = colors.red, bg = "#2a0a0a" })
vim.api.nvim_set_hl(0, "DiffChange", { fg = colors.yellow, bg = "#2a2a0a" })
vim.api.nvim_set_hl(0, "DiffText", { fg = colors.yellow, bg = "#2a2a10" })

-- Spelling
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = colors.red })
vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = colors.blue })
vim.api.nvim_set_hl(0, "SpellLocal", { undercurl = true, sp = colors.yellow })
vim.api.nvim_set_hl(0, "SpellRare", { undercurl = true, sp = colors.purple })

-- Pmenu (completion menu)
vim.api.nvim_set_hl(0, "Pmenu", { fg = colors.grey70, bg = colors.grey1 })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors.bg, bg = colors.sky, bold = true })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = colors.grey1 })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = colors.grey23 })

-- Folding
vim.api.nvim_set_hl(0, "Folded", { fg = colors.blue, bg = colors.grey0 })
vim.api.nvim_set_hl(0, "FoldColumn", { fg = colors.blue, bg = "NONE" })

-- Tabs
vim.api.nvim_set_hl(0, "TabLine", { fg = colors.grey50, bg = "NONE" })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = colors.sky, bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })

-- Quickfix
vim.api.nvim_set_hl(0, "qfLineNr", { fg = colors.orange })

-- Bufferline
vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "NONE" })
vim.api.nvim_set_hl(0, "BufferlineBufferSelected", { fg = colors.sky, bold = true })
vim.api.nvim_set_hl(0, "BufferlineSeparator", { fg = colors.grey23 })
vim.api.nvim_set_hl(0, "BufferlineBuffer", { fg = colors.grey70, bg = "NONE" })
vim.api.nvim_set_hl(0, "BufferlineOffset", { fg = colors.grey70, bg = "NONE" })

-- NvimTree
vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = colors.grey70, bg = "NONE" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { fg = colors.grey70, bg = "NONE" })
vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = colors.sky })
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = colors.orange })
vim.api.nvim_set_hl(0, "NvimTreeFileName", { fg = colors.grey70 })
vim.api.nvim_set_hl(0, "NvimTreeFileIcon", { fg = colors.turquoise })
vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = colors.grey50 })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = colors.sky, bold = true })
vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#0a0a2e" })
vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = colors.green })
vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = colors.red })
-- Additional nvim-tree file type highlights
vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = colors.green })
vim.api.nvim_set_hl(0, "NvimTreeSymlink", { fg = colors.turquoise })
vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = colors.grey70 })
vim.api.nvim_set_hl(0, "NvimTreeImageFile", { fg = colors.grey70 })
vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = colors.sky, bold = true })
