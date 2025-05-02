return {
  'ThePrimeagen/harpoon',
  event = 'VeryLazy',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    local fzf = require 'fzf-lua'

    harpoon:setup()
    local map = vim.keymap.set

    map('n', '<leader>h', function()
      harpoon:list():add()
    end)

    map('n', '<C-h>', function()
      harpoon:list():select(1)
    end)
    map('n', '<C-j>', function()
      harpoon:list():select(2)
    end)
    map('n', '<C-k>', function()
      harpoon:list():select(3)
    end)
    map('n', '<C-l>', function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    map('n', '<C-S-P>', function()
      harpoon:list():prev()
    end)
    map('n', '<C-S-N>', function()
      harpoon:list():next()
    end)

    local function harpoon_fzf_picker()
      local marks = harpoon:list().items
      local entries = {}
      for idx, mark in pairs(marks) do
        local filepath = vim.fn.fnamemodify(mark.value, ':~:.')
        table.insert(entries, string.format('[%d] %s', idx, filepath))
      end

      fzf.fzf_exec(entries, {
        prompt = 'Harpoon> ',
        file_icons = 'devicons', -- Requires nvim-web-devicons
        git_icons = true, -- Show git status if applicable
        actions = {
          ['default'] = function(selected)
            local idx = tonumber(selected[1]:match '%[(%d+)%]')
            if idx then
              harpoon:list():select(idx)
            end
          end,
          ['ctrl-k'] = function(selected)
            local idx = tonumber(selected[1]:match '%[(%d+)%]')
            if idx then
              harpoon:list():remove_at(idx)
              harpoon_fzf_picker()
            end
          end,
        },
        winopts = {
          height = 0.4,
          width = 0.8,
          preview = { hidden = true },
        },
        previewer = 'builtin',
      })
    end
    vim.keymap.set('n', '<C-e>', function()
      harpoon_fzf_picker()
    end, { desc = 'Open harpoon window' })
  end,
}
