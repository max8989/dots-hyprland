return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent = false,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
        terminal_colors = true,
        theme = {
          variant = "default", -- use "light" for light mode
          highlights = {
            -- Custom highlights can be added here
          }
        },
      })
      vim.cmd.colorscheme "cyberdream"
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 900,
    config = function()
      require("catppuccin").setup({
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = false,
          mini = false,
        },
      })
    end
  },
  {
    "folke/tokyonight.nvim",
    priority = 800,
    config = function()
      require("tokyonight").setup({
        transparent = false,
        styles = {
          sidebars = "dark",
          floats = "dark",
        },
      })
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 700,
    config = function()
      require("rose-pine").setup({
        disable_background = false,
        disable_float_background = false,
      })
    end
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 600,
    config = function()
      require("kanagawa").setup({
        transparent = false,
        theme = "wave",
        background = {
          dark = "wave",
          light = "lotus"
        },
      })
    end
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 500,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          }
        }
      })
    end
  },
  {
    "EdenEast/nightfox.nvim",
    name = "carbonfox",
    priority = 400,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          }
        }
      })
    end
  }
}
