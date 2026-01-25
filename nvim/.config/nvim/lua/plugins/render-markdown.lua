return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown" },
  opts = {
    enabled = true,
    render_modes = { "n", "c" },
    file_types = { "markdown" },
    code = {
      enabled = true,
      sign = true,
      style = "full",
      position = "left",
      language_icon = true,
      language_name = true,
      width = "full",
      border = "thin",
      above = "▄",
      below = "▀",
      highlight = "RenderMarkdownCode",
    },
    heading = {
      enabled = true,
      sign = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)

    -- Keybindings
    vim.keymap.set("n", "<leader>mr", function()
      require("render-markdown").toggle()
      -- Show status message
      local state = require("render-markdown").get()
      if state then
        vim.notify("Markdown rendering enabled", vim.log.levels.INFO)
      else
        vim.notify("Markdown rendering disabled", vim.log.levels.INFO)
      end
    end, {
      desc = "Toggle Markdown Rendering",
    })
    
    vim.keymap.set("n", "<leader>mv", ":RenderMarkdown preview<CR>", {
      silent = true,
      desc = "Markdown Preview (side-by-side)",
    })
  end,
}
