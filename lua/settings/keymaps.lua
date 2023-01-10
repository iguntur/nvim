-- Set Leader to a comma - <leader>
vim.g.mapleader = ","
vim.g.maplocalleader = ","

--------------------------------------------------------------------------------
-- Map Helper Function
--------------------------------------------------------------------------------
local keymap = vim.keymap.set
local options = { silent = true }

--------------------------------------------------------------------------------
-- Common Shortcut
--------------------------------------------------------------------------------
--- Control (⌃ / ctrl)
--- Alt/Options (⌥)
--- Super/Command (⌘ / window)
--- Shift (⇧)

-- Allow gf to open non-existent files
keymap("", "gf", ":edit <cfile><CR>", options)

-- Reload (source nvim.config): F5
-- keymap("n", "<F5>", ":source $HOME/.config/nvim/init.lua<CR><Esc>", options)

-- Disable Arrow-keys
for _, k in pairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
	keymap("n", k, "<Nop>", options)
	keymap("v", k, "<Nop>", options)
end

-- Disable terminal clear scren (Cmd+k)
-- keymap("", "<Cmd>k", "<Nop>", options)
keymap("", "<Cmd-k>", "<Nop>", options)

keymap("n", "q:", "<Nop>", options) -- disable unexpected macro
keymap("n", "Q", "<Nop>", options)

-- Set space/del/backspace to Esc
-- keymap("n", "<space>", "<Esc>", options)
keymap("n", "<Del>", "<Esc>", options)
keymap("n", "<BS>", "<Esc>", options)
-- keymap("n", '<C-space>', '<Esc>0', options) -- Control+space

-- Clear the highlight search
keymap("n", "<Esc>", ":nohlsearch<CR><Esc>", options)

--------------------------------------------------------------------------------
-- Text Editing
--------------------------------------------------------------------------------
-- Copy-Paste
keymap("v", "p", '"_dP', options) -- keep the "yank" value

-- Pair Space
-- keymap("i", "<M-Space>", "<Esc>2a<space><Esc>i", options)
-- keymap("n", "<M-Space>", "<Esc>2a<space><Esc>i", options)
keymap({ "n", "i" }, "<M-Space>", "<Esc>2a<space><Esc>i", options)

--------------------------------------------------------------------------------
-- Cursor movement
--------------------------------------------------------------------------------
-- Move cursor to the first character: (shift + h)
keymap("n", "H", "^<ESC>", options)

-- Move cursor to the last character: (shift + l)
keymap("n", "L", "$<ESC>", options)

-- Move cursor when insert mode: (control) + (h/j/k/l)
keymap("i", "<C-h>", "<Left>", options)
keymap("i", "<C-j>", "<Down>", options)
keymap("i", "<C-k>", "<Up>", options)
keymap("i", "<C-l>", "<Right>", options)

--------------------------------------------------------------------------------
-- Jump line
--------------------------------------------------------------------------------
keymap("n", "<C-k>", "9kzz0", options) -- up 9 lines
keymap("n", "<C-j>", "9jzz0", options) -- down 9 lines

keymap("v", "<M-;>", "9k", options) -- select in visual mode
keymap("v", "<M-'>", "9j", options) -- select in visual mode

keymap("n", "<C-d>", "<C-d>zzzv0", options)
keymap("n", "<C-u>", "<C-u>zzzv0", options)

keymap("n", "gg", "gg0", options)
keymap("n", "G", "G0zz", options)
keymap("n", "{", "{zz0", options)
keymap("n", "}", "}zz0", options)

keymap("n", "n", "nzzzv", options)
keymap("n", "N", "Nzzzv", options)

--------------------------------------------------------------------------------
-- Buffer and File
--------------------------------------------------------------------------------
-- Write or saving file: (⌥ or alt) + s
keymap("v", "<M-s>", "<ESC><CMD>w<CR><ESC>", options)
keymap("n", "<M-s>", "<CMD>w<CR><ESC>", options)
keymap("i", "<M-s>", "<ESC><CMD>w<CR><ESC>a", options) -- allow writing in insert mode

-- Close current buffer: (⌥ or alt) + w
-- keymap("n", '<M-w>', ':bw<ESC>', options)
keymap("n", "<M-w>", ":BufferClose<CR>", options)
keymap("n", "<M-W>", ":BufferClose!<CR>", options)

--------------------------------------------------------------------------------
-- Navigate buffers
--------------------------------------------------------------------------------
-- keymap("n", '<TAB>', ':bnext<CR>', options) -- tab
-- keymap("n", '<S-TAB>', ':bprevious<CR>', options) -- shift+tab
keymap("n", "<TAB>", ":bprevious<CR>", options) -- tab
keymap("n", "<S-TAB>", ":bnext<CR>", options) -- shift+tab

--------------------------------------------------------------------------------
-- Indentation
--------------------------------------------------------------------------------
-- indent to the right: Shift + >
keymap("v", ">", ">gv", options)
keymap("n", ">", ">>_", options)

-- indent to the left: shift + <
keymap("v", "<", "<gv", options)
keymap("n", "<", "<<_", options)

--------------------------------------------------------------------------------
-- Insert Empty Line(s)
--------------------------------------------------------------------------------
-- Insert empty line on top cursor and up: Control+Alt+k
keymap("n", "<M-C-K>", '<S-o><ESC>"_cc<ESC>', options)

-- Insert empty line on bottom cursor and down: Control+Alt+j
keymap("n", "<M-NL>", 'o<ESC>"_cc<ESC>', options)

--------------------------------------------------------------------------------
-- Duplicate Line(s)
--------------------------------------------------------------------------------
-- Duplicate Line Up: Alt+Shift+k
keymap("n", "<M-K>", '<ESC>^<ESC>"0yy "0P<ESC>', options)
keymap("v", "<M-K>", "<NOP>", options)

-- Duplicate Line Down: Alt+Shift+j
keymap("n", "<M-J>", '<ESC>^<ESC>"0yy "0p<ESC>', options)
keymap("v", "<M-J>", "<NOP>", options)

--------------------------------------------------------------------------------
-- Delete Line(s)
--------------------------------------------------------------------------------
-- Remove(Cut) active line: Alt+d
keymap("n", "<M-d>", '"_dd<ESC>', options)
keymap("v", "<M-d>", '"_d<ESC>', options)

--------------------------------------------------------------------------------
-- Utilities
--------------------------------------------------------------------------------
-- Sort Lines Natural (Asc): space+s
-- keymap("v", '<space>s', ':\'<,\'>!sort -f<CR><ESC>', options)

--------------------------------------------------------------------------------
-- Window
--------------------------------------------------------------------------------
-- Window Navigation
keymap("n", "<C-Left>", "<C-w>h", options) -- move cursor to "left" window
keymap("n", "<C-Down>", "<C-w>j", options) -- move cursor to "bottom" window
keymap("n", "<C-Up>", "<C-w>k", options) -- move cursor to "top" window
keymap("n", "<C-Right>", "<C-w>l", options) -- move cursor to "right" window

--------------------------------------------------------------------------------
-- Resize window (Ctrl-Shift-<Arrow_Keys>)
--------------------------------------------------------------------------------
keymap("n", "<C-S-Up>", ":resize +1<CR>", options) -- " Up
keymap("n", "<C-S-Down>", ":resize -1<CR>", options) -- " Down
keymap("n", "<C-S-Left>", ":vertical resize -1<CR>", options) -- " Left
keymap("n", "<C-S-Right>", ":vertical resize +1<CR>", options) -- " Right

--------------------------------------------------------------------------------
-- Terminal
--------------------------------------------------------------------------------
-- Terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", options)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", options)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", options)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", options)

--------------------------------------------------------------------------------
-- Jump tmux session
--------------------------------------------------------------------------------
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", options)

--------------------------------------------------------------------------------
-- Misc
--------------------------------------------------------------------------------
-- do not yank with x
keymap("n", "x", '"_x', options)

-- Increment/decrement
keymap("n", "+", "<C-a>", options)
keymap("n", "-", "<C-x>", options)

-- delete word from the end
keymap("n", "dw", 'viw"_d', options)

-- select all
keymap("n", "<C-a>", "gg<S-v>G", options)

--------------------------------------------------------------------------------
-- ...
--------------------------------------------------------------------------------
