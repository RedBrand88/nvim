vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.html",
  callback = function()
    local lines = {
      "<!DOCTYPE html>",
      "<html>",
      "    <head>",
      "      <title> </title>",
      "      <link rel='stylesheet' href='style.css'>",
      "    </head>",
      "    <body>",
      "        ",
      "    </body>",
      "</html>",
    }

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

    vim.api.nvim_win_set_cursor(0, { 7, 8 })
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.go",
  callback = function()
    local lines = {
      "package main",
      "",
      "import (",
      "  \"fmt\"",
      ")",
      "",
      "func main() {",
      "  fmt.Println(\"Hello, World!\")",
      "}",
    }

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

    vim.api.nvim_win_set_cursor(0, { 7, 4 })
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.tsx",
  callback = function()
    local filename = vim.fn.expand("%:t:r") -- %:t gets the filename, :r removes the extension
    local componentName = filename:sub(1, 1):upper() .. filename:sub(2)

    local lines = {
      "import * as React from 'react';",
      "",
      "type " .. componentName .. "Props = {",
      "  //add props here",
      "};",
      "const " .. componentName .. " = ({}: " .. componentName .. "Props) => {",
      "  return (",
      "    <div>",
      "      ",
      "    </div>",
      "  );",
      "};",
      "",
      "export default " .. componentName .. ";",
    }

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

    vim.api.nvim_win_set_cursor(0, { 9, 6 })
  end,
})
