local dapui = require("dapui")
local dap = require("dap")

-- open the ui as soon as we are debugging
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- https://emojipedia.org/en/stickers/search?q=circle
vim.fn.sign_define('DapBreakpoint',
  {
    text = '⚪',
    texthl = 'DapBreakpointSymbol',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint'
  })

vim.fn.sign_define('DapStopped',
  {
    text = '🔴',
    texthl = 'yellow',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint'
  })
vim.fn.sign_define('DapBreakpointRejected',
  {
    text = '⭕',
    texthl = 'DapStoppedSymbol',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint'
  })

-- more minimal ui
dapui.setup({
  expand_lines = true,
  controls = { enabled = false }, -- no extra play/step buttons
  floating = { border = "rounded" },

  -- Set dapui window
  render = {
    max_type_length = 60,
    max_value_lines = 200,
  },

  -- Only one layout: just the "scopes" (variables) list at the bottom
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.5 },  -- 50% of width
        { id = "console", size = 0.5 }, -- 50% of width (right side)
      },
      size = 15,                        -- height in lines (adjust to taste)
      position = "bottom",              -- "left", "right", "top", "bottom"
    },
  },
})

-- Auto-resize dap-ui when window layout changes (useful for tiling WMs like Hyprland)
local dapui_resize_group = vim.api.nvim_create_augroup("dapui_resize", { clear = true })

-- Helper function to reset dapui if session is active
local function reset_dapui_layout()
  if dap.session() then
    vim.schedule(function()
      dapui.open({ reset = true })
    end)
  end
end

-- Trigger on Neovim window resize (Hyprland/WM resizing)
vim.api.nvim_create_autocmd("VimResized", {
  group = dapui_resize_group,
  callback = reset_dapui_layout,
})

-- Trigger when windows are created or closed (neo-tree, toggleterm, splits, etc.)
vim.api.nvim_create_autocmd({ "WinClosed", "WinNew" }, {
  group = dapui_resize_group,
  callback = function()
    -- Small delay to let the window layout settle
    vim.defer_fn(reset_dapui_layout, 50)
  end,
})

vim.keymap.set("n", "<leader>dr", function()
  dapui.open({ reset = true })
end, { desc = "DAP UI reset layout" })


vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI toggle" })

vim.keymap.set({ "n", "v" }, "<leader>dw", function() dapui.eval(nil, { enter = true }) end, { desc = "DAP Add word under cursor to Watches" })
vim.keymap.set({ "n", "v" }, "Q", function() dapui.eval() end, { desc = "DAP Peek" })

local neotest = require("neotest")

vim.keymap.set("n", "<leader>dt", function() neotest.run.run({ strategy = "dap" }) end, { desc = "Debug nearest test" })
vim.keymap.set("n", "<F6>", function() neotest.run.run({ strategy = "dap" }) end, { desc = "Debug nearest test" })
vim.keymap.set("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Close quickfix list" })
