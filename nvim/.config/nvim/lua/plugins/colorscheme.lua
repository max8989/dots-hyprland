return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup()
      vim.cmd.colorscheme "catppuccin"
    end
  },
  {
    "folke/tokyonight.nvim",
    priority = 900,
    config = function()
      require("tokyonight").setup()
      vim.cmd.colorscheme "tokyonight"
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 800,
    config = function()
      require("rose-pine").setup()
      vim.cmd.colorscheme "rose-pine"
    end
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 500,
    config = function()
      require("kanagawa").setup()
      vim.cmd.colorscheme "kanagawa"
    end
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 400,
    config = function()
      require("nightfox").setup()
      vim.cmd.colorscheme "nightfox"
    end
  },
  {
    "EdenEast/nightfox.nvim",
    name = "carbonfox",
    priority = 300,
    config = function()
      require("nightfox").setup()
      vim.cmd.colorscheme "carbonfox"
    end
  }
}
