local function get_all_keymaps()
  local modes = { "n", "i", "v", "x", "c", "t" }
  local result = {}

  for _, mode in ipairs(modes) do
    for _, map in ipairs(vim.api.nvim_get_keymap(mode)) do
      table.insert(result, string.format("[%s] %s → %s", mode, map.lhs, map.desc or map.rhs or "<lua/cmd>"))
    end
  end

  return result
end

local function open_keymap_window()
  local keymaps = get_all_keymaps()
  local buf = vim.api.nvim_create_buf(false, true) -- [listed = false, scratch = true]

  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Key Map", string.rep("=", width - 2) })
  vim.api.nvim_buf_set_lines(buf, 2, -1, false, keymaps)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- Close with `q`
  vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
end

-- Return a table or a function to hook into
return {
  open = open_keymap_window,
}
