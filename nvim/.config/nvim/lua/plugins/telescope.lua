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
        local cheat_file = vim.fn.stdpath("config") .. "/cheat-sheet.md"
        local lines = vim.fn.readfile(cheat_file)
        local cheatsheet_data = {}
        
        local current_section = ""
        for _, line in ipairs(lines) do
          if line:match("^|%s*Section") then
            -- Skip header row
          elseif line:match("^|%-") then
            -- Skip separator row
          elseif line:match("^|") then
            -- Parse table row
            local section, keybinding, description = line:match("^|%s*(.-)%s*|%s*`?(.-)`?%s*|%s*(.-)%s*|")
            if section and keybinding and description then
              if section ~= current_section and current_section ~= "" then
                table.insert(cheatsheet_data, { "", "", "", "separator" })
              end
              current_section = section
              if keybinding ~= "" then
                table.insert(cheatsheet_data, { section, description, keybinding, "key" })
              end
            end
          end
        end

        require('telescope.pickers').new({}, {
          prompt_title = "Custom Cheat Sheet",
          finder = require('telescope.finders').new_table({
            results = cheatsheet_data,
            entry_maker = function(entry)
              local section, desc, key, type = entry[1], entry[2], entry[3], entry[4]
              local display
              
              if type == "separator" then
                display = ""
              else
                display = string.format("%-20s  %-35s %s", section, desc, key)
              end
              
              return {
                value = entry,
                display = display,
                ordinal = section .. " " .. desc .. " " .. key,
              }
            end,
          }),
          sorter = require('telescope.config').values.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
            map('i', '<CR>', function()
              local selection = require('telescope.actions.state').get_selected_entry()
              require('telescope.actions').close(prompt_bufnr)
              if selection.value[3] ~= "" then
                -- Copy the keybinding to clipboard
                vim.fn.setreg('+', selection.value[3])
                print("Copied: " .. selection.value[3])
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
