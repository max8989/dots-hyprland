return {
  "chentoast/marks.nvim",
  event = "BufReadPre",
  config = function()
    require("marks").setup({
      -- Whether to map keybinds or not. default true
      default_mappings = true,

      -- Which builtin marks to show. default {}
      -- '.' for last change, '^' for last position, etc.
      builtin_marks = { ".", "<", ">", "^" },

      -- Whether movements cycle back to the beginning/end when reaching top/bottom
      cyclic = true,

      -- Force display signs in the sign column
      force_write_shada = false,

      -- Refresh interval for signs (in ms)
      refresh_interval = 250,

      -- Sign priorities (lower = higher priority, default 10)
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },

      -- Bookmark configuration (Capital letters)
      bookmark_0 = {
        sign = "⚑",
        virt_text = "bookmark",
        -- Highlight groups
        sign_hl = "MarkSignHL",
        virt_text_hl = "MarkVirtTextHL",
      },

      -- Mapping configuration
      mappings = {
        -- Toggle mark at current line
        set = "m",
        -- Delete mark
        delete = "dm",
        -- Delete mark on current line (if any)
        delete_line = "dm-",
        -- Delete all marks in buffer
        delete_buf = "dm<space>",
        -- Jump to next mark
        next = "]m",
        -- Jump to previous mark
        prev = "[m",
        -- Preview mark (show in floating window)
        preview = "m:",

        -- Set bookmark (capital letters)
        set_bookmark0 = "m0",
        set_bookmark1 = "m1",
        set_bookmark2 = "m2",
        set_bookmark3 = "m3",
        set_bookmark4 = "m4",
        set_bookmark5 = "m5",
        set_bookmark6 = "m6",
        set_bookmark7 = "m7",
        set_bookmark8 = "m8",
        set_bookmark9 = "m9",

        -- Delete bookmark
        delete_bookmark = "dm=",
        delete_bookmark0 = "dm0",

        -- Jump to next/previous bookmark
        next_bookmark = "]`",
        prev_bookmark = "[`",
        next_bookmark0 = "]0",
        prev_bookmark0 = "[0",
      }
    })

    -- Custom highlight colors for marks
    vim.api.nvim_set_hl(0, 'MarkSignHL', { fg = '#00ff00' })  -- Green for regular marks
    vim.api.nvim_set_hl(0, 'MarkSignNumHL', { fg = '#ffff00' })  -- Yellow for numbered marks
    vim.api.nvim_set_hl(0, 'MarkVirtTextHL', { fg = '#666666' })  -- Gray for virtual text
  end
}