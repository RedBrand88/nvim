local M = {}

M.live_grep_file_filter = function()
  vim.ui.input({prompt = "Directory to search in: "}, function(input)
    local opts = {
      glob_pattern = {}
    }
    if input ~= "" then
      opts.search_dirs = {input}
    end
    require('telescope.builtin').live_grep(opts)
  end)
end

return M

