return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
  },
  config = function()
    require("dapui").setup()
    local dap, dapui = require("dap"), require("dapui")

    require("dap-go").setup()
    require("dapui").setup()

    -- .NET Core debugging configuration
    dap.adapters.coreclr = {
      type = 'executable',
      command = 'netcoredbg',
      args = {'--interpreter=vscode'}
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = false,
        console = "internalConsole",
      },
      {
        type = "coreclr",
        name = "launch with stop at entry",
        request = "launch",
        program = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        console = "internalConsole",
      },
    }

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    vim.keymap.set("n", "<Leader>dt", ':DapToggleBreakpoint<CR>')
    vim.keymap.set("n", "<Leader>dx", ':DapTerminate<CR>')
    vim.keymap.set("n", "<Leader>do", ':DapStepOver<CR>')
    vim.keymap.set("n", "<Leader>di", ':DapStepInto<CR>')
    vim.keymap.set("n", "<Leader>dc", ':DapContinue<CR>')
    vim.keymap.set("n", "<Leader>dr", ':DapToggleRepl<CR>')
  end
}
