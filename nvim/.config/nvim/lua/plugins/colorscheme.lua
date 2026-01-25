return {
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.background = "dark"
      vim.cmd.colorscheme("oxocarbon")
      
      -- Lighten background colors for better visibility
      vim.api.nvim_set_hl(0, "Normal", { bg = "#262626", fg = "#e0e0e0" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#2d2d2d", fg = "#e0e0e0" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "#242424", fg = "#e0e0e0" })
      
      -- Lighten UI elements
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "#262626" })
      vim.api.nvim_set_hl(0, "LineNr", { bg = "#262626", fg = "#6e6e6e" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#262626", fg = "#b0b0b0", bold = true })
      vim.api.nvim_set_hl(0, "Folded", { bg = "#2d2d2d", fg = "#a0a0a0" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#262626", fg = "#4e4e4e" })
      
      -- Improve status line visibility
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "#3a3a3a", fg = "#e0e0e0" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#2d2d2d", fg = "#909090" })
      
      -- Better contrast for selections and search
      vim.api.nvim_set_hl(0, "Visual", { bg = "#3d3d3d" })
      vim.api.nvim_set_hl(0, "Search", { bg = "#4a4a4a", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "IncSearch", { bg = "#5a5a5a", fg = "#ffffff" })
    end,
  },
}
