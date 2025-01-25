local opt = vim.opt

-- Set Leader to a comma - <leader>
vim.g.mapleader = ","
vim.g.maplocalleader = ";"

--------------------------------------------------------------------------------
-- Text encoding and editing
--------------------------------------------------------------------------------
opt.autoindent = true
opt.backspace = { "indent", "eol", "start" }
opt.cindent = true
opt.cino = ":0" -- (C Lang) No indent for case:/default:
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.expandtab = false -- convert tabs to spaces
opt.shiftwidth = 4
opt.smarttab = true
opt.softtabstop = 4
opt.swapfile = false
opt.tabstop = 4
opt.textwidth = 110
opt.wrap = false
opt.linebreak = true
opt.undofile = true -- enable persistent undo
opt.undodir = vim.fn.expand("$HOME/.cache/nvim-undodir")
opt.clipboard = ""
opt.shortmess:append("I") -- Disable Neovim welcome page
opt.shortmess:append("Ws") -- Disable Neovim welcome page

--------------------------------------------------------------------------------
-- Interface
--------------------------------------------------------------------------------
-- vim.opt.guicursor = {
--     "n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
--     "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
--     "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
-- }

opt.background = "dark"
opt.colorcolumn = "80,110,120"
opt.cursorline = true
opt.laststatus = 3
opt.list = true
-- opt.listchars = { tab = "▸ ", trail = "·", eol = "↴" } -- eol = '↲'
opt.listchars = {
    tab = "▸ ",
    trail = "·",
    -- eol = "↴",
    -- eol = '↲',
}
opt.mouse = "a"
opt.numberwidth = 6
opt.ruler = true
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.title = true
opt.wildmenu = true
opt.wildmode = "longest:full,full"
-- opt.t_Co           = '256'
-- opt.wildcharm      = 4
opt.pumheight = 10 -- pop up menu height
opt.completeopt = { "menu", "menuone", "noselect" }
opt.termguicolors = true -- enable 24-bit RGB colors
opt.splitbelow = true -- make all horizontal split to go below window
opt.splitright = true -- make all vertical split to go to the right
opt.backup = false -- create backup file
opt.number = true
opt.relativenumber = true
opt.smoothscroll = true -- Optional but improves reproducibility
opt.statuscolumn = [[%!v:lua.require('util.ui').statuscolumn()]]
opt.signcolumn = "auto:3"

-- vim.cmd([[ set winbar=%f ]])
-- vim.o.ls = 0
-- vim.o.ch = 0
--------------------------------------------------------------------------------
-- Search
--------------------------------------------------------------------------------
opt.hlsearch = true -- highlight search result
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true -- move cursor to search as you type
opt.showmatch = true
opt.wildignore:append({
    "*/node_modules/*",
    "*/vendor/*",
})

--------------------------------------------------------------------------------
-- LSP Stuff
--------------------------------------------------------------------------------
-- vim.cmd([[ set tagfunc=v:lua.vim.lsp.tagfunc ]])
