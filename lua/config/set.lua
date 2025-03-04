local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25
-- g.copilot_no_tab_map = true
opt.nu = true
opt.relativenumber = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
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
