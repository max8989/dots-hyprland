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

    -- Terminal keymappings
    vim.keymap.set('n', '<C-`>', function()
      vim.cmd('ToggleTerm direction=float size=100')
    end, { desc = "Toggle fullscreen terminal" })

    -- Multiple terminal instances
    vim.keymap.set('n', '<leader>t1', function()
      vim.cmd('1ToggleTerm direction=horizontal')
    end, { desc = "Toggle terminal 1" })

    vim.keymap.set('n', '<leader>t2', function()
      vim.cmd('2ToggleTerm direction=horizontal')
    end, { desc = "Toggle terminal 2" })

    vim.keymap.set('n', '<leader>t3', function()
      vim.cmd('3ToggleTerm direction=horizontal')
    end, { desc = "Toggle terminal 3" })

    -- Different terminal layouts
    vim.keymap.set('n', '<leader>th', function()
      vim.cmd('ToggleTerm direction=horizontal size=20')
    end, { desc = "Toggle horizontal terminal" })

    vim.keymap.set('n', '<leader>tv', function()
      vim.cmd('ToggleTerm direction=vertical size=50')
    end, { desc = "Toggle vertical terminal" })

    vim.keymap.set('n', '<leader>tf', function()
      vim.cmd('ToggleTerm direction=float')
    end, { desc = "Toggle floating terminal" })

    vim.keymap.set('n', '<leader>tt', function()
      vim.cmd('ToggleTerm direction=tab')
    end, { desc = "Toggle terminal in new tab" })

    -- Terminal resizing shortcuts
    vim.keymap.set('n', '<leader>tr+', function()
      vim.cmd('ToggleTerm size=' .. vim.fn.winheight(0) + 5)
    end, { desc = "Increase terminal height" })

    vim.keymap.set('n', '<leader>tr-', function()
      vim.cmd('ToggleTerm size=' .. math.max(5, vim.fn.winheight(0) - 5))
    end, { desc = "Decrease terminal height" })

    -- Quick terminal commands
    vim.keymap.set('n', '<leader>tg', function()
      vim.cmd('TermExec cmd="lazygit" direction=float')
    end, { desc = "Open LazyGit in terminal" })

    vim.keymap.set('n', '<leader>tp', function()
      vim.cmd('TermExec cmd="python3" direction=horizontal')
    end, { desc = "Open Python REPL" })

    vim.keymap.set('n', '<leader>tn', function()
      vim.cmd('TermExec cmd="node" direction=horizontal')
    end, { desc = "Open Node.js REPL" })

    -- Kill all terminals
    vim.keymap.set('n', '<leader>tk', function()
      vim.cmd('TermClose!')
    end, { desc = "Kill all terminals" })

    -- Terminal navigation in terminal mode
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- Apply terminal keymaps when entering terminal
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    -- Force quit terminals on exit
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        vim.cmd("TermClose!")
      end,
    })
  end,
}
