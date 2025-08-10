return {
  "sudormrfbin/cheatsheet.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("cheatsheet").setup({
      bundled_cheatsheets = {
        enabled = { "default", "lua", "markdown", "regex", "netrw", "unicode" },
        disabled = { "nerd-fonts" },
      },
      bundled_plugin_cheatsheets = {
        enabled = {
          "auto-session",
          "goto-preview",
          "octo.nvim",
          "telescope.nvim",
          "vim-easy-align",
          "vim-sandwich",
        },
        disabled = { "gitsigns" },
      },
      include_only_installed_plugins = true,
      telescope_mappings = {
        ["<CR>"] = require("cheatsheet.telescope.actions").select_or_fill_commandline,
        ["<A-CR>"] = require("cheatsheet.telescope.actions").select_or_execute,
        ["<C-Y>"] = require("cheatsheet.telescope.actions").copy_cheat_value,
        ["<C-E>"] = require("cheatsheet.telescope.actions").edit_user_cheatsheet,
      },
    })

    -- Keybinding to open cheatsheet
    vim.keymap.set("n", "<leader>ch", ":Cheatsheet<CR>", { desc = "Open cheatsheet" })
  end,
}
