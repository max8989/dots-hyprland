return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<C-j>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      auto_scroll = true,
      on_exit = function()
        vim.cmd("checktime")
      end,
      shell = vim.fn.has('win32') == 1 and 'powershell' or vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })

    -- Fullscreen terminal mapping
    vim.keymap.set('n', '<C-`>', function()
      vim.cmd('ToggleTerm direction=float size=100')
    end, { desc = "Toggle fullscreen terminal" })

    -- Force quit terminals on exit
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        vim.cmd("TermClose!")
      end,
    })
  end,
}
