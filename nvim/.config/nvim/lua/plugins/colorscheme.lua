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

            -- Improve text visibility
            Normal = { fg = "#ffffff", bg = "NONE" },
            NormalFloat = { fg = "#ffffff", bg = "#1e2124" },
            FloatBorder = { fg = "#5ea1ff", bg = "#1e2124" },

            -- Terminal colors
            TermCursor = { fg = "#16181a", bg = "#ffffff" },
            TermCursorNC = { fg = "#16181a", bg = "#ffffff" },

            -- Make comments more visible
            Comment = { fg = "#7b8496", italic = true },

            -- String colors
            String = { fg = "#a1d9a5" },

            -- Function and identifier colors
            Function = { fg = "#5ea1ff" },
            Identifier = { fg = "#ffffff" },

            -- Make line numbers more visible
            LineNr = { fg = "#7b8496" },
            CursorLineNr = { fg = "#5ea1ff", bold = true },
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

      -- Additional terminal color overrides
      vim.api.nvim_set_hl(0, 'Terminal', { fg = '#ffffff', bg = 'NONE' })

      -- Override terminal ANSI colors for better visibility
      vim.g.terminal_color_0 = '#3c4048'  -- black (brighter)
      vim.g.terminal_color_1 = '#ff6e5e'  -- red
      vim.g.terminal_color_2 = '#5ef1ff'  -- green
      vim.g.terminal_color_3 = '#f1ff5e'  -- yellow
      vim.g.terminal_color_4 = '#5ea1ff'  -- blue
      vim.g.terminal_color_5 = '#bd5eff'  -- magenta
      vim.g.terminal_color_6 = '#5ef1ff'  -- cyan
      vim.g.terminal_color_7 = '#ffffff'  -- white (brighter)

      -- Bright variants
      vim.g.terminal_color_8 = '#7b8496'   -- bright black
      vim.g.terminal_color_9 = '#ff6e5e'   -- bright red
      vim.g.terminal_color_10 = '#5ef1ff'  -- bright green
      vim.g.terminal_color_11 = '#f1ff5e'  -- bright yellow
      vim.g.terminal_color_12 = '#5ea1ff'  -- bright blue
      vim.g.terminal_color_13 = '#bd5eff'  -- bright magenta
      vim.g.terminal_color_14 = '#5ef1ff'  -- bright cyan
      vim.g.terminal_color_15 = '#ffffff'  -- bright white
    end,
  },
}
