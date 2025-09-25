local keymap = vim.keymap
local api = vim.api

keymap.set("n", "<leader>e", vim.cmd.Ex)

keymap.set("n", "<leader>nv", "<C-w><C-v>")
keymap.set("n", "<leader>sf", ":vert sf ")

keymap.set("n", "--", "<C-w><")
keymap.set("n", "++", "<C-w>>")

keymap.set("n", "<leader>L", "<C-w>L")
keymap.set("n", "<leader>H", "<C-w>H")
keymap.set("n", "<leader>h", "<C-w>h")
keymap.set("n", "<leader>j", "<C-w>j")
keymap.set("n", "<leader>k", "<C-w>k")
keymap.set("n", "<leader>l", "<C-w>l")

keymap.set("n", "<leader>nx", vim.cmd.close)
keymap.set("n", "<leader>cx", ":cclose<CR>", {desc = "Close quick fix window"})
keymap.set("n", "<leader>wo", "<C-w>o")

keymap.set("i", "jj", "<Esc>")

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- next greatest remap ever : asbjornHaland
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

keymap.set({ "n", "v" }, "<leader>d", [["_d]])

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/bbashein/plugins.lua<CR>");

keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

-- api.nvim_set_keymap("i", "<C-o>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- required for pair programming or for when your manager is looking at your code
api.nvim_set_keymap("n", "<leader>r", "<cmd>lua require('config.line_numbers').toggle_line_numbers()<CR>",
  { noremap = true, silent = true })

api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>ng", "<cmd>lua require('config.live_grep_file_filter').live_grep_file_filter()<CR>",
  { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cs", require("config.cheatsheet").open, { desc = "Show keymap cheatsheet" })
