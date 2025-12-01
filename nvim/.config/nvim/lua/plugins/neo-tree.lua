return  {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = false, -- neo-tree will lazily load itself
  config = function()
    vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', {})
    --   vim.keymap.set('n', '<C-b>', ':Neotree filesystem reveal left<CR>', {})
    require("neo-tree").setup({
      window = {
        mappings = {
          -- Vim-style fold mappings for recursive operations
          ["z"] = "none", -- Disable default 'z' to use fold-style bindings
          ["zo"] = "toggle_node",
          ["zO"] = "expand_all_subnodes", -- Recursively expand current folder only
          ["zc"] = "close_node",
          ["zC"] = "close_all_subnodes", -- Recursively close current node
          ["za"] = "toggle_node",
          ["zM"] = "close_all_nodes", -- Close all nodes
          ["zR"] = "expand_all_nodes", -- Open all nodes in tree
          ["E"] = "expand_all_subnodes", -- Recursively expand current folder only
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = false, -- This will prevent auto-expanding to current file
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        use_libuv_file_watcher = false, -- This will prevent auto-refresh which can cause expansion
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            -- Auto close neo-tree when a file is opened
            -- Comment this out if you don't want auto-close
            -- require("neo-tree.command").execute({ action = "close" })
          end
        },
      },
    })
  end
}

