return {
  'mhartington/formatter.nvim',
  config = function()
    local util = require "formatter.util"

    return function(parser)
      if not parser then
        return {
          exe = "prettier",
          args = {
            "--tab-width",
            2,
            "--no-semi",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
          },
          stdin = true,
          try_node_modules = true,
        }
      end

      return {
        exe = "prettier",
        args = {
          "--tab-width",
          2,
          "--no-semi",
          "--stdin-filepath",
          util.escape_path(util.get_current_buffer_file_path()),
          "--parser",
          parser,
        },
        stdin = true,
        try_node_modules = true,
      }
    end
  end
}
