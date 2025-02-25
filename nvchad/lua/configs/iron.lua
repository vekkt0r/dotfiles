local config = function()
  local view = require "iron.view"
  local common = require "iron.fts.common"

  return {
    config = {
      repl_definition = {
        sh = {
          command = { "fish" },
        },
        python = {
          command = { "python3" },
          format = common.brackeded_paste_python,
          block_deviders = { "# %%", "#%%" },
        },
      },
      repl_open_cmd = view.bottom(function()
        return math.floor(vim.o.lines / 3)
      end),
    },
    keymaps = {
      send_motion = "<space>sc",
      visual_send = "<space>sc",
      send_file = "<space>sf",
      send_line = "<space>sl",
      send_until_cursor = "<space>su",
      send_mark = "<space>sm",
      send_code_block = "<space>sb",
      send_code_block_and_move = "<space>sn",
      mark_motion = "<space>mc",
      mark_visual = "<space>mc",
      remove_mark = "<space>md",
      cr = "<space>s<cr>",
      interrupt = "<space>s<space>",
      exit = "<space>sq",
      clear = "<space>cL",
    },
  }
end

return config
