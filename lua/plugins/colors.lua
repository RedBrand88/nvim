function ColorMyTheme(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require('rose-pine').setup({})

            vim.cmd("colorscheme rose-pine")

            ColorMyTheme()
        end
    },
}

