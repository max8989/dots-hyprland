return { { "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent = false,
        italic_comments = true,
        hide_fillchars = false,
        borderless_telescope = false,
        terminal_colors = true,
        theme = {
          variant = "default", -- use "light" for light mode
          highlights = {
            -- Make vertical split separators visible
            VertSplit = { fg = "#3c4048", bg = "NONE" },
            WinSeparator = { fg = "#3c4048", bg = "NONE" },
          }
        },
        -- Disable or enable colorscheme extensions
        extensions = {
          telescope = true,
          notify = true,
          mini = true,
          alpha = true,
          cmp = true,
          gitsigns = true,
          lazy = true,
          treesitter = true,
        },
      })
      vim.cmd.colorscheme "cyberdream"
    end,
  },
}
