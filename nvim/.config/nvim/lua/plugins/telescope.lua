return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          hidden = true,
          file_ignore_patterns = { ".git/" },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
      vim.keymap.set("n", "<leader>bb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>cs", function()
        local cheatsheet_data = {
          -- Buffer Management
          { "● Buffer Management", "", "header" },
          { "Next buffer", "<Tab>", "key" },
          { "Previous buffer", "<S-Tab>", "key" },
          { "Delete current buffer", "<leader>bd", "key" },
          { "", "", "separator" },
          
          -- File Navigation
          { "● File Navigation & Search", "", "header" },
          { "Find files", "<C-p>", "key" },
          { "Live grep (search text)", "<leader>fg", "key" },
          { "Recent files", "<leader><leader>", "key" },
          { "Open buffers", "<leader>bb", "key" },
          { "", "", "separator" },
          
          -- File Explorer
          { "● File Explorer", "", "header" },
          { "Toggle file tree", "<C-n>", "key" },
          { "Reveal current file in tree", "<C-b>", "key" },
          { "", "", "separator" },
          
          -- Terminal
          { "● Terminal", "", "header" },
          { "Toggle terminal", "<C-`>", "key" },
          { "", "", "separator" },
          
          -- LSP
          { "● LSP (Language Server)", "", "header" },
          { "Show hover documentation", "K", "key" },
          { "Go to definition", "<leader>gd", "key" },
          { "Find references", "<leader>gr", "key" },
          { "Code actions", "<leader>ca", "key" },
          { "Format code", "<leader>gf", "key" },
          { "", "", "separator" },
          
          -- Debugging
          { "● Debugging (DAP)", "", "header" },
          { "Toggle breakpoint", "<leader>dt", "key" },
          { "Start/Continue debugging", "<leader>dc", "key" },
          { "Terminate debugger", "<leader>dx", "key" },
          { "Step over", "<leader>do", "key" },
          { "Step into", "<leader>di", "key" },
          { "Toggle REPL", "<leader>dr", "key" },
          { "", "", "separator" },
          
          -- Markdown
          { "● Markdown", "", "header" },
          { "Toggle markdown preview", "<leader>mp", "key" },
          { "", "", "separator" },
          
          -- Command Line
          { "● Command Line", "", "header" },
          { "Enhanced command mode", ":", "key" },
          { "", "", "separator" },
          
          -- Cheat Sheet
          { "● Cheat Sheet", "", "header" },
          { "Open built-in cheatsheet", "<leader>ch", "key" },
          { "Open this custom cheat sheet", "<leader>cs", "key" },
        }

        require('telescope.pickers').new({}, {
          prompt_title = "Custom Cheat Sheet",
          finder = require('telescope.finders').new_table({
            results = cheatsheet_data,
            entry_maker = function(entry)
              local desc, key, type = entry[1], entry[2], entry[3]
              local display
              
              if type == "header" then
                display = string.format("%-45s", desc)
              elseif type == "separator" then
                display = ""
              else
                display = string.format("  %-43s %s", desc, key)
              end
              
              return {
                value = entry,
                display = display,
                ordinal = desc .. " " .. key,
              }
            end,
          }),
          sorter = require('telescope.config').values.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
            map('i', '<CR>', function()
              local selection = require('telescope.actions.state').get_selected_entry()
              require('telescope.actions').close(prompt_bufnr)
              if selection.value[2] ~= "" and selection.value[3] == "key" then
                -- Copy the keybinding to clipboard
                vim.fn.setreg('+', selection.value[2])
                print("Copied: " .. selection.value[2])
              end
            end)
            return true
          end,
        }):find()
      end, { desc = "Search custom cheat sheet" })

      require("telescope").load_extension("ui-select")
    end,
  },
}
