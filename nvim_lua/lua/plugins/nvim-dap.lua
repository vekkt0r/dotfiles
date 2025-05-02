return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'
    dap.adapters.gdb = {
      types = 'executable',
      command = 'gdb',
      args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
    }
    dap.adapters.python = {
      type = 'executable',
      command = vim.g.python3_host_prog,
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    }
    dap.configurations.c = {
      {
        name = 'Attach',
        request = 'attach',
        type = 'gdb',
        target = ':3333',
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
      },
    }
    dap.configurations.python = {
      {
        name = 'Launch file',
        request = 'launch',
        type = 'python',
        program = '${file}',
      },
    }
  end,
}
