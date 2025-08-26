return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    -- Custom buffer delete function that maintains window layout
    local function smart_buffer_delete(bufnr)
      bufnr = bufnr or vim.api.nvim_get_current_buf()
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
    end
    
    require("bufferline").setup({
      options = {
        mode = "buffers",
        numbers = "none",
        close_command = function(bufnr)
          smart_buffer_delete(bufnr)
        end,
        right_mouse_command = function(bufnr)
          smart_buffer_delete(bufnr)
        end,
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = '▎',
          style = 'icon',
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          }
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
      }
    })
    
    -- Keymaps for buffer navigation
    vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { silent = true, desc = 'Next buffer' })
    vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { silent = true, desc = 'Previous buffer' })
    vim.keymap.set('n', '<leader>bp', ':BufferLineTogglePin<CR>', { silent = true, desc = 'Pin/Unpin buffer' })
    vim.keymap.set('n', '<leader>bP', ':BufferLinePick<CR>', { silent = true, desc = 'Pick buffer' })
    vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { silent = true, desc = 'Pick buffer to close' })
    vim.keymap.set('n', '<leader>bh', ':BufferLineCloseLeft<CR>', { silent = true, desc = 'Close buffers to the left' })
    vim.keymap.set('n', '<leader>bl', ':BufferLineCloseRight<CR>', { silent = true, desc = 'Close buffers to the right' })
  end
}