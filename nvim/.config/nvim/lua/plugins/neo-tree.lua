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

