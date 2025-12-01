vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader= " "
vim.g.maplocalleader = "\\"

--Line numbers
vim.wo.number = true
vim.wo.relativenumber = true
vim.cmd("set ignorecase")

-- Accent-insensitive search: u matches u, ù, ú, û, ü, etc.
-- Use \C in your search to override and make it case-sensitive when needed
vim.keymap.set('n', '/', function()
  local accent_map = {
    a = '[aàáâãäåāăąǎ]', A = '[AÀÁÂÃÄÅĀĂĄǍ]',
    e = '[eèéêëēĕėęě]', E = '[EÈÉÊËĒĔĖĘĚ]',
    i = '[iìíîïĩīĭįı]', I = '[IÌÍÎÏĨĪĬĮ]',
    o = '[oòóôõöøōŏő]', O = '[OÒÓÔÕÖØŌŎŐ]',
    u = '[uùúûüũūŭůű]', U = '[UÙÚÛÜŨŪŬŮŰ]',
    c = '[cçćĉċč]', C = '[CÇĆĈĊČ]',
    n = '[nñńņň]', N = '[NÑŃŅŇ]',
  }

  vim.ui.input({ prompt = '/' }, function(pattern)
    if not pattern then return end

    -- Expand each letter to include accented variants
    local expanded = pattern:gsub('[a-zA-Z]', function(c)
      return accent_map[c] or c
    end)

    vim.fn.setreg('/', expanded)
    vim.cmd('set hlsearch')
    pcall(vim.cmd, 'normal! n')
  end)
end, { desc = 'Search with accent folding' })

vim.opt.confirm = false

-- Enable system clipboard integration
-- This makes "+y and "*y copy to system clipboard
-- Also makes regular y/p operations use the system clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.undofile = true  -- Enable persistent undo across sessions
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
-- Better search experience
vim.opt.incsearch = true  -- Show search results as you type
vim.opt.scrolloff = 8      -- Keep 8 lines visible above/below cursor

-- Auto-save when switching buffers
vim.opt.autowriteall = true

vim.opt.cursorline = true  -- Highlight current line

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

-- Transparency settings (disabled)
-- vim.opt.pumblend = 15
-- vim.opt.winblend = 15

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

-- Auto change to project root when opening files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    -- Skip empty buffers and special buffer types (terminals, etc.)
    if bufname == "" or vim.bo[args.buf].buftype ~= "" then
      return
    end

    -- Find project root using common markers
    local root = vim.fs.root(args.buf, {'.git', 'Makefile', 'package.json', 'Cargo.toml', 'go.mod', 'pom.xml', 'build.gradle', '.sln', '.csproj', '.root'})
    if root and root ~= vim.fn.getcwd() then
      vim.cmd('cd ' .. root)
      -- Uncomment to see when directory changes
      -- print("Changed directory to: " .. root)
    end
  end,
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
vim.cmd("highlight WinSeparator guifg=#44475a")

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Clear search highlighting with Escape
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { silent = true })

-- Delete without yanking to clipboard (use black hole register)
vim.keymap.set('n', 'x', '"_x', { desc = 'Delete character without yanking' })
vim.keymap.set('n', 'X', '"_X', { desc = 'Delete character backwards without yanking' })
vim.keymap.set('n', 'd', '"_d', { desc = 'Delete without yanking' })
vim.keymap.set('n', 'D', '"_D', { desc = 'Delete to end of line without yanking' })
vim.keymap.set('n', 'dd', '"_dd', { desc = 'Delete line without yanking' })
vim.keymap.set('v', 'd', '"_d', { desc = 'Delete selection without yanking' })
vim.keymap.set('v', 'x', '"_x', { desc = 'Delete selection without yanking' })

-- Use leader+d for cut (delete and yank)
vim.keymap.set('n', '<leader>d', '"+d', { desc = 'Cut (delete and yank to clipboard)' })
vim.keymap.set('n', '<leader>dd', '"+dd', { desc = 'Cut line (delete and yank to clipboard)' })
vim.keymap.set('v', '<leader>d', '"+d', { desc = 'Cut selection (delete and yank to clipboard)' })
