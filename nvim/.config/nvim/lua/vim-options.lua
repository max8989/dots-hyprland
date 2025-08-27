vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader= " "
vim.g.maplocalleader = "\\"

--Line numbers
vim.wo.number = true
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.opt.confirm = false

-- Buffer navigation keybindings
-- Commented out in favor of bufferline navigation (using <S-h> and <S-l>)
-- vim.keymap.set('n', '<Tab>', ':bnext<CR>', { silent = true })     -- Move to next buffer
-- vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { silent = true })   -- Move to previous buffer

-- Smart buffer delete that maintains window layout
vim.keymap.set('n', '<leader>bd', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local windows = vim.fn.getbufinfo(bufnr)[1].windows
  
  -- If buffer is displayed in multiple windows, just switch buffers
  if #windows > 1 then
    vim.cmd('bprevious')
  else
    -- Get list of all listed buffers
    local buffers = vim.tbl_filter(function(b)
      return vim.bo[b].buflisted
    end, vim.api.nvim_list_bufs())
    
    -- If this is the last buffer, create a new empty one
    if #buffers == 1 then
      vim.cmd('enew')
    else
      -- Switch to previous buffer before deleting
      vim.cmd('bprevious')
    end
  end
  
  -- Delete the buffer
  vim.cmd('bdelete! ' .. bufnr)
end, { silent = true, desc = 'Delete current buffer (smart)' })

-- Transparency settings
vim.opt.pumblend = 15
vim.opt.winblend = 15
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalFloat guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
vim.cmd("highlight EndOfBuffer guibg=NONE ctermbg=NONE")

-- Auto-reload files when changed externally
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})

-- Split settings for visible separators
vim.opt.fillchars = {
  vert = '│',     -- Vertical split separator
  horiz = '─',    -- Horizontal split separator  
  horizup = '┴',
  horizdown = '┬',
  vertleft = '┤',
  vertright = '├',
  verthoriz = '┼'
}

-- Highlight the split lines
vim.cmd("highlight WinSeparator guifg=#44475a guibg=NONE")

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Clear search highlighting with Escape
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { silent = true })
