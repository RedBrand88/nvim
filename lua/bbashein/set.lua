local opt = vim.opt
local g = vim.g

g.airline_theme = "solarized"
g.mapleader = " "
g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25
opt.nu = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50
