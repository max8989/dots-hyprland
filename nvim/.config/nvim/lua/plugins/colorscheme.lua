return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
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
      vim.cmd.colorscheme "catppuccin"
    end
  },
  {
    "folke/tokyonight.nvim",
    priority = 900,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd.colorscheme "tokyonight"
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 800,
    config = function()
      require("rose-pine").setup({
        disable_background = true,
        disable_float_background = true,
      })
      vim.cmd.colorscheme "rose-pine"
    end
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 500,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        theme = "wave",
        background = {
          dark = "wave",
          light = "lotus"
        },
      })
      vim.cmd.colorscheme "kanagawa"
    end
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 400,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          }
        }
      })
      vim.cmd.colorscheme "nightfox"
    end
  },
  {
    "EdenEast/nightfox.nvim",
    name = "carbonfox",
    priority = 300,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          }
        }
      })
      vim.cmd.colorscheme "carbonfox"
    end
  }
}
