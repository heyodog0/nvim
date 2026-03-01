-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = ""
vim.opt.cursorline = true
vim.opt.foldenable = false  -- Disable folding completely
vim.opt.timeoutlen = 200  -- Faster leader key timeout (default 1000ms)

-- Disable cursorline in terminal for performance
vim.api.nvim_create_autocmd('TermEnter', {
  callback = function()
    vim.opt.cursorline = false
  end
})

vim.api.nvim_create_autocmd('TermLeave', {
  callback = function()
    vim.opt.cursorline = true
  end
})

-- Plugin specs
require("lazy").setup({
  -- Noice (cmdline popup and notifications)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        view = "cmdline_popup",
        format = {
          cmdline = { icon = ":", lang = "vim" },
          search_down = { icon = "/", lang = "regex" },
          search_up = { icon = "?", lang = "regex" },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = "100%",
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
      },
      messages = {
        view = "notify",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },

  -- Lualine (statusline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      }
    }
  },

  -- Bufferline (buffer tabs)
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    version = "*",
    opts = {
      options = {
        close_command = "bdelete! %d",
        diagnostics = "nvim_lsp",
        separator_style = "thin",
      }
    }
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },

  -- Indent blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {}
  },

  -- Comment.nvim
  {
    'numToStr/Comment.nvim',
    opts = {}
  },

  -- nvim-tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      view = { width = 30, side = 'left' },
      renderer = { group_empty = true },
      filters = { dotfiles = false },
    }
  },

  -- Telescope (fuzzy finder)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = "Telescope",
    opts = {}
  },

  -- Mason (LSP/DAP installer)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {}
  },

  -- Mason LSP config bridge
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {}
  },

  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  },

  -- Conform (formatter)
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {}
  },

  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
    }
  },

  -- nvim-treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { "python", "lua", "rust", "json", "yaml", "toml", "markdown", "bash" },
      sync_install = false,
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    }
  },


  -- Trouble (better diagnostics)
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols" },
      { "<leader>cL", "<cmd>Trouble lsp toggle<cr>", desc = "LSP" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Loclist" },
    },
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Flash (enhanced motions)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    },
  },

  -- Illuminate (highlight references)
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
  },

  -- Dressing (better UI dialogs)
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Mini (small useful modules)
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.pairs").setup()
    end,
  },

  -- smear-cursor
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      smear_between_buffers = false,
      smear_between_neighbor_lines = false,
      scroll_buffer_space = false,
      legacy_computing_symbols_support = true,
      smear_insert_mode = false,
      time_interval = 5,
      damping = .9
    }
  },
})

-- Colorscheme
vim.cmd.colorscheme('moonfly-ghostty')

-- LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
  end,
})

-- LSP servers using vim.lsp.config (new API)
vim.lsp.config.ruff = {}
vim.lsp.config.rust_analyzer = {}
vim.lsp.config.lua_ls = {}
vim.lsp.config.pyright = {}
vim.lsp.config.gopls = {}
vim.lsp.config.ts_ls = {}
vim.lsp.config.jsonls = {}
vim.lsp.config.yamlls = {}

vim.lsp.enable('ruff')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('gopls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('jsonls')
vim.lsp.enable('yamlls')

-- Conform formatters
require('conform').setup({
  formatters_by_ft = {
    python = { "ruff_format", "ruff_fix" },
    rust = { "rustfmt" },
    lua = { "stylua" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    json = { "jq" },
    yaml = { "yamlfix" },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    if vim.bo.buftype ~= 'terminal' then
      require("conform").format({ bufnr = args.buf })
    end
  end,
})

-- NEW PLUGIN KEYBINDINGS
-- Flash.nvim - Enhanced motions
--   s       : Jump to any word in view (normal/visual/operator mode)
--   S       : Treesitter-aware jump (normal/visual/operator mode)
--   r       : Jump for operator pending (e.g., rs"word" for surround)

-- Trouble.nvim - Diagnostics
--   <leader>xx  : Toggle diagnostics list
--   <leader>xb  : Toggle buffer diagnostics only
--   <leader>cs  : Toggle symbols list
--   <leader>cL  : Toggle LSP references
--   <leader>xq  : Toggle quickfix list
--   <leader>xl  : Toggle location list

-- Illuminate - Reference highlighting (automatic)
--   Shows all references to word under cursor automatically
--   No keybind needed - just place cursor on a word

-- Mini.nvim
--   ai      : Text objects for code (a/i followed by identifier)
--             Examples: daw (delete around word), cii (change inside identifier)
--   surround: Add/delete/change surrounding characters
--             Examples: sa" (add quotes), sd" (delete quotes), sr"' (replace quotes)
--   pairs   : Better bracket pairing (automatic)

-- Keymaps
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { desc = "Toggle file tree" })
vim.keymap.set('n', '<leader>m', ':NvimTreeFocus<CR>', { desc = "Focus file tree" })
vim.keymap.set('n', '<leader>t', ':Telescope<CR>', { desc = "Open telescope" })
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "Find files" })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = "Live grep" })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = "Find buffers" })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = "Find help" })
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { desc = "Vertical split" })
vim.keymap.set('n', '<leader>s', ':split<CR>', { desc = "Horizontal split" })
vim.keymap.set('n', '<leader>q', ':close<CR>', { desc = "Close split" })
vim.keymap.set('n', '<leader>/', '/', { desc = "Search" })
vim.keymap.set('n', ']c', ':Gitsigns next_hunk<CR>', { desc = "Next git change" })
vim.keymap.set('n', '[c', ':Gitsigns prev_hunk<CR>', { desc = "Previous git change" })
vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', { desc = "Preview git change" })
vim.keymap.set('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = "Git blame" })
vim.keymap.set('n', '<leader>bd', ':BufferLineCyclePrev<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>bn', ':BufferLineCycleNext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<leader>bx', ':bdelete!<CR>', { desc = "Close buffer" })

-- Terminal toggle function
local function toggle_terminal()
  local term_buf = nil
  local term_win = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
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
      vim.cmd('belowright split')
      vim.api.nvim_buf_set_option(term_buf, 'buflisted', true)
      vim.api.nvim_win_set_buf(0, term_buf)
      vim.cmd('startinsert')
    end
  else
    vim.cmd('belowright split | terminal')
    vim.cmd('startinsert')
  end
end

-- Open in Finder
local function open_in_finder()
  local path = nil
  if vim.bo.filetype == 'NvimTree' then
    local ok, api = pcall(require, 'nvim-tree.api')
    if ok then
      local node = api.tree.get_node_under_cursor()
      if node then
        path = node.absolute_path or node.link_to
      end
    end
  else
    path = vim.fn.expand('%:p')
  end
  if not path or path == '' then
    vim.notify('No file selected to open', vim.log.levels.WARN)
    return
  end
  vim.fn.jobstart({ 'open', path }, { detach = true })
end

-- Custom keymaps (original)
vim.keymap.set('n', '<leader>r', ':belowright split | terminal uv run %<CR>i', { desc = "Run current file with uv" })
vim.keymap.set('n', '<leader>c', ':belowright split | terminal cargo run<CR>i', { desc = "Run cargo project" })
vim.keymap.set('n', '<leader>j', toggle_terminal, { desc = "Toggle terminal" })
vim.keymap.set('n', '<leader>o', open_in_finder, { desc = "Open in Finder" })
vim.keymap.set('t', '<leader>j', toggle_terminal, { desc = "Toggle terminal from terminal mode" })
