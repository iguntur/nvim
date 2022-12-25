-- Set Leader to a comma - <leader>
vim.g.mapleader = ","
vim.g.maplocalleader = ","

--------------------------------------------------------------------------------
-- Map Helper Function
--------------------------------------------------------------------------------
local keymap = vim.keymap.set

--------------------------------------------------------------------------------
-- Common Shortcut
--------------------------------------------------------------------------------
--- Control (⌃ / ctrl)
--- Alt/Options (⌥)
--- Super/Command (⌘ / window)
--- Shift (⇧)

-- Allow gf to open non-existent files
keymap("", "gf", ":edit <cfile><CR>", { silent = true })

-- Reload (source nvim.config): F5
-- keymap("n", "<F5>", ":source $HOME/.config/nvim/init.lua<CR><Esc>", { silent = true })

-- Disable Arrow-keys
for _, k in pairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
	keymap("n", k, "<Nop>")
	keymap("v", k, "<Nop>")
end

-- Disable terminal clear scren (Cmd+k)
-- keymap("", "<Cmd>k", "<Nop>", { silent = true })
keymap("", "<Cmd-k>", "<Nop>", { silent = true })

keymap("n", "q:", "<Nop>") -- disable unexpected macro

-- Set space/del/backspace to Esc
-- keymap("n", "<space>", "<Esc>")
keymap("n", "<Del>", "<Esc>")
keymap("n", "<BS>", "<Esc>")
-- keymap("n", '<C-space>', '<Esc>0') -- Control+space

-- Clear the highlight search
keymap("n", "<Esc>", ":nohlsearch<CR><Esc>")

--------------------------------------------------------------------------------
-- Text Editing
--------------------------------------------------------------------------------
-- Copy-Paste
keymap("v", "p", '"_dP') -- keep the "yank" value

-- Pair Space
-- keymap("i", "<M-Space>", "<Esc>2a<space><Esc>i")
-- keymap("n", "<M-Space>", "<Esc>2a<space><Esc>i")
keymap({ "n", "i" }, "<M-Space>", "<Esc>2a<space><Esc>i")

--------------------------------------------------------------------------------
-- Cursor movement
--------------------------------------------------------------------------------
-- Move cursor to the first character: (shift + h)
keymap("n", "H", "^<ESC>")

-- Move cursor to the last character: (shift + l)
keymap("n", "L", "$<ESC>")

-- Move cursor when insert mode: (control) + (h/j/k/l)
keymap("i", "<C-h>", "<Left>")
keymap("i", "<C-j>", "<Down>")
keymap("i", "<C-k>", "<Up>")
keymap("i", "<C-l>", "<Right>")

keymap("n", "<C-k>", "9kzz") -- up 9 lines
keymap("n", "<C-j>", "9jzz") -- down 9 lines

keymap("v", "<M-;>", "9k") -- select in visual mode
keymap("v", "<M-'>", "9j") -- select in visual mode
--------------------------------------------------------------------------------
-- Buffer and File
--------------------------------------------------------------------------------
-- Write or saving file: (⌥ or alt) + s
keymap("v", "<M-s>", "<ESC>:w<CR><ESC>")
keymap("n", "<M-s>", ":w<CR><ESC>")
keymap("i", "<M-s>", "<ESC>:w<CR><ESC>a") -- allow writing in insert mode

-- Close current buffer: (⌥ or alt) + w
-- keymap("n", '<M-w>', ':bw<ESC>')
keymap("n", "<M-w>", ":BufferClose<CR>")
keymap("n", "<M-W>", ":BufferClose!<CR>")

--------------------------------------------------------------------------------
-- Navigate buffers
--------------------------------------------------------------------------------
-- keymap("n", '<TAB>', ':bnext<CR>') -- tab
-- keymap("n", '<S-TAB>', ':bprevious<CR>') -- shift+tab
keymap("n", "<TAB>", ":bprevious<CR>") -- tab
keymap("n", "<S-TAB>", ":bnext<CR>") -- shift+tab

--------------------------------------------------------------------------------
-- Indentation
--------------------------------------------------------------------------------
-- indent to the right: Shift + >
keymap("v", ">", ">gv")
keymap("n", ">", ">>_")

-- indent to the left: shift + <
keymap("v", "<", "<gv")
keymap("n", "<", "<<_")

--------------------------------------------------------------------------------
-- Insert Empty Line(s)
--------------------------------------------------------------------------------
-- Insert empty line on top cursor and up: Control+Alt+k
keymap("n", "<M-C-K>", '<S-o><ESC>"_cc<ESC>')

-- Insert empty line on bottom cursor and down: Control+Alt+j
keymap("n", "<M-NL>", 'o<ESC>"_cc<ESC>')

--------------------------------------------------------------------------------
-- Duplicate Line(s)
--------------------------------------------------------------------------------
-- Duplicate Line Up: Alt+Shift+k
keymap("n", "<M-K>", '<ESC>^<ESC>"0yy "0P<ESC>')
keymap("v", "<M-K>", "<NOP>")

-- Duplicate Line Down: Alt+Shift+j
keymap("n", "<M-J>", '<ESC>^<ESC>"0yy "0p<ESC>')
keymap("v", "<M-J>", "<NOP>")

--------------------------------------------------------------------------------
-- Delete Line(s)
--------------------------------------------------------------------------------
-- Remove(Cut) active line: Alt+d
keymap("n", "<M-d>", '"_dd<ESC>')
keymap("v", "<M-d>", '"_d<ESC>')

--------------------------------------------------------------------------------
-- Utilities
--------------------------------------------------------------------------------
-- Sort Lines Natural (Asc): space+s
-- keymap("v", '<space>s', ':\'<,\'>!sort -f<CR><ESC>')

--------------------------------------------------------------------------------
-- Window
--------------------------------------------------------------------------------
-- Window Navigation
keymap("n", "<C-Left>", "<C-w>h") -- move cursor to "left" window
keymap("n", "<C-Down>", "<C-w>j") -- move cursor to "bottom" window
keymap("n", "<C-Up>", "<C-w>k") -- move cursor to "top" window
keymap("n", "<C-Right>", "<C-w>l") -- move cursor to "right" window

--------------------------------------------------------------------------------
-- Resize window (Ctrl-Shift-<Arrow_Keys>)
--------------------------------------------------------------------------------
keymap("n", "<C-S-Up>", ":resize +1<CR>") -- " Up
keymap("n", "<C-S-Down>", ":resize -1<CR>") -- " Down
keymap("n", "<C-S-Left>", ":vertical resize -1<CR>") -- " Left
keymap("n", "<C-S-Right>", ":vertical resize +1<CR>") -- " Right

--------------------------------------------------------------------------------
-- Terminal
--------------------------------------------------------------------------------
-- Terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l")

--------------------------------------------------------------------------------
-- Misc
--------------------------------------------------------------------------------
-- do not yank with x
keymap("n", "x", '"_x')

-- Increment/decrement
keymap("n", "+", "<C-a>")
keymap("n", "-", "<C-x>")

-- delete word from the end
keymap("n", "dw", 'viw"_d')

-- select all
keymap("n", "<C-a>", "gg<S-v>G")

--------------------------------------------------------------------------------
-- ...
--------------------------------------------------------------------------------
