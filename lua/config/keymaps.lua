--------------------------------------------------------------------------------
-- Map Helper Function
--------------------------------------------------------------------------------
local keymap = vim.keymap
local options = { silent = true, noremap = true }

-- vim.keymap.del({ "n", "t" }, "<C-/>")
-- vim.keymap.del({ "n", "t" }, "<c-/>")

--------------------------------------------------------------------------------
-- Common Shortcut
--------------------------------------------------------------------------------
--- Control (⌃ / ctrl)
--- Alt/Options (⌥)
--- Super/Command (⌘ / window)
--- Shift (⇧)

-- Allow gf to open non-existent files
-- keymap.set("", "gf", ":edit <cfile><CR>", options)

-- Reload (source nvim.config): F5
-- keymap.set("n", "<F5>", ":source $HOME/.config/nvim/init.lua<CR><Esc>", options)

-- Disable Arrow-keys
for _, k in pairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
    keymap.set({ "n", "v" }, k, "<Nop>", options)
end

-- Disable keys
local disable_keys = { "Q", "<Cmd-k>" }
for _, k in pairs(disable_keys) do
    keymap.set({ "n", "v" }, k, "<Nop>", options)
end

-- Set space/del/backspace to Esc
keymap.set("n", "<Del>", "<Esc>", options)
keymap.set("n", "<BS>", "<Esc>", options)

-- Clear the highlight search
keymap.set("n", "<Esc>", ":nohlsearch<CR><Esc>", options)

--------------------------------------------------------------------------------
-- Text Editing
--------------------------------------------------------------------------------
-- Copy-Paste
keymap.set("v", "p", '"_dP', options) -- keep the "yank" value

-- Pair Space
-- keymap.set("i", "<M-Space>", "<Esc>2a<space><Esc>i", options)
-- keymap.set("n", "<M-Space>", "<Esc>2a<space><Esc>i", options)
keymap.set({ "n", "i" }, "<M-Space>", "<Esc>2a<space><Esc>i", options)

-- comments (Ctrl + /)
keymap.set({ "n", "i" }, "<c-_>", "<Esc>gcc<Esc>", { silent = true, remap = true })
keymap.set("v", "<c-_>", "gc<Esc>", { silent = true, remap = true })

--------------------------------------------------------------------------------
-- Cursor movement
--------------------------------------------------------------------------------
-- Move cursor to the first character: (shift + h)
keymap.set("n", "H", "^<ESC>", options)

-- Move cursor to the last character: (shift + l)
keymap.set("n", "L", "$<ESC>", options)

-- Move cursor when insert mode: (control) + (h/j/k/l)
-- keymap.set("i", "<C-h>", "<Left>", options)
-- keymap.set("i", "<C-j>", "<Down>", options)
-- keymap.set("i", "<C-k>", "<Up>", options)
-- keymap.set("i", "<C-l>", "<Right>", options)

--------------------------------------------------------------------------------
-- Scroll
--------------------------------------------------------------------------------
keymap.set("n", "j", "gj<esc>zzzv", options)
keymap.set("n", "k", "gk<esc>zzzv", options)

--------------------------------------------------------------------------------
-- Jump line
--------------------------------------------------------------------------------
-- keymap.set("n", "<C-k>", "9kzz0", options) -- up 9 lines
-- keymap.set("n", "<C-j>", "9jzz0", options) -- down 9 lines

keymap.set("v", "<M-'>", "9k", options) -- select in visual mode
keymap.set("v", "<M-;>", "9j", options) -- select in visual mode

-- keymap.set("n", "<C-d>", "<C-d>zzzv0", options)
-- keymap.set("n", "<C-u>", "<C-u>zzzv0", options)

keymap.set("n", "gg", "gg0", options)
keymap.set("n", "G", "G0zz", options)
keymap.set("n", "{", "{zz0", options)
keymap.set("n", "}", "}zz0", options)

keymap.set("n", "n", "nzzzv", options)
keymap.set("n", "N", "Nzzzv", options)

--------------------------------------------------------------------------------
-- Indentation
--------------------------------------------------------------------------------
-- indent to the right: Shift + >
keymap.set("v", ">", ">gv", options)
keymap.set("n", ">", ">>_", options)

-- indent to the left: shift + <
keymap.set("v", "<", "<gv", options)
keymap.set("n", "<", "<<_", options)

--------------------------------------------------------------------------------
-- Insert Empty Line(s)
--------------------------------------------------------------------------------
-- Insert empty line on top cursor and up: Control+Alt+k
keymap.set("n", "<M-C-K>", '<S-o><ESC>"_cc<ESC>', options)

-- Insert empty line on bottom cursor and down: Control+Alt+j
keymap.set("n", "<M-NL>", 'o<ESC>"_cc<ESC>', options)

--------------------------------------------------------------------------------
-- Copy Paste - register to default editor clipboard
--------------------------------------------------------------------------------
keymap.set({ "n", "v" }, "y", '"ay', { silent = true, noremap = true, desc = "Copy into default editor clipboard" })
keymap.set({ "n", "v" }, "p", '"ap', { silent = true, noremap = true, desc = "Paste from default editor clipboard" })
keymap.set({ "n", "v" }, "P", '"aP', { silent = true, noremap = true, desc = "Paste from default editor clipboard" })

keymap.set({ "n", "v" }, "d", '"ad', { silent = true, noremap = true, desc = "Copy into default editor clipboard" })
keymap.set({ "n", "v" }, "D", '"aD', { silent = true, noremap = true, desc = "Copy into default editor clipboard" })

--------------------------------------------------------------------------------
-- Copy Paste - register to system clipboard
--------------------------------------------------------------------------------
keymap.set("n", "<leader>y", '"+y', { silent = true, noremap = true, desc = "Copy into system clipboard" })
keymap.set("v", "<leader>y", '"+y', { silent = true, noremap = true, desc = "Copy into system clipboard" })
keymap.set("n", "<leader>Y", '"+Y', { silent = true, noremap = true, desc = "Copy into system clipboard" })

--------------------------------------------------------------------------------
-- Duplicate Line(s)
--------------------------------------------------------------------------------
-- Duplicate Line Up: Alt+Shift+k
keymap.set("n", "<M-K>", function()
    local cursor = vim.fn.getpos(".") -- current cursor position

    vim.cmd("t.")
    vim.fn.setpos(".", cursor)
end, options)

-- Duplicate Line Down: Alt+Shift+j
-- Duplicate Line Down: Alt+Shift+j
keymap.set("n", "<M-J>", function()
    local cursor = vim.fn.getpos(".") -- current cursor position
    local lineNumber = cursor[2]
    local column = cursor[3]

    vim.cmd("t.")
    vim.fn.setpos(".", { 0, lineNumber + 1, column, 0 })
end, options)

keymap.set("v", "<M-K>", "<NOP>", options)
keymap.set("v", "<M-J>", "<NOP>", options)

--------------------------------------------------------------------------------
-- Delete Line(s)
--------------------------------------------------------------------------------
-- Remove(Cut) active line: Alt+d
keymap.set("n", "<M-d>", '"_dd<ESC>', options)
keymap.set("v", "<M-d>", '"_d<ESC>', options)

--------------------------------------------------------------------------------
-- Utilities
--------------------------------------------------------------------------------
-- Sort Lines Natural (Asc): space+s
-- keymap.set("v", '<space>s', ':\'<,\'>!sort -f<CR><ESC>', options)

--------------------------------------------------------------------------------
-- Buffer and File
--------------------------------------------------------------------------------
-- keymap.set("n", "<M-]>", ":bnext<CR>", { silent = true, noremap = true, desc = "Next buffer" })
-- keymap.set("n", "<M-[>", ":bprevious<CR>", { silent = true, noremap = true, desc = "Previous buffer" })

-- Write or saving file: (⌥ or alt) + s
keymap.set("v", "<M-s>", "<ESC><CMD>w<CR><ESC>", options)
keymap.set("n", "<M-s>", "<CMD>w<CR><ESC>", options)
keymap.set("i", "<M-s>", "<ESC><CMD>w<CR><ESC>a", options) -- allow writing in insert mode
keymap.set("n", "<M-S>", "<CMD>wa<CR><ESC>", options)

-- Close current buffer: (⌥ or alt) + w
-- keymap.set("n", '<M-w>', ':bw<ESC>', options)
keymap.set("n", "<M-w>", ":bdelete<CR>", options)
keymap.set("n", "<M-W>", ":bdelete!<CR>", options)

--------------------------------------------------------------------------------
-- Tab
--------------------------------------------------------------------------------
keymap.set("n", "<leader><tab><tab>", ":tabnew<CR>", { silent = true, noremap = true, desc = "Create a new tab" })
keymap.set("n", "<leader><tab>d", ":tabclose<CR>", { silent = true, noremap = true, desc = "Close tab" })
keymap.set("n", "<leader><tab>f", ":tabfirst<CR>", { silent = true, noremap = true, desc = "Jump to the first tab" })
keymap.set("n", "<leader><tab>l", ":tablast<CR>", { silent = true, noremap = true, desc = "Jump to the last tab" })

-- Navigate tab
keymap.set("n", "<tab>", ":tabnext<CR>", { silent = true, noremap = true, desc = "Move to next tab" }) -- tab
keymap.set("n", "<S-tab>", ":tabprevious<CR>", { silent = true, noremap = true, desc = "Move to previous tab" }) -- shift+tab
keymap.set("n", "<M-]>", ":tabnext<CR>", { silent = true, noremap = true, desc = "Move to next tab" })
keymap.set("n", "<M-[>", ":tabprevious<CR>", { silent = true, noremap = true, desc = "Move to previous tab" })
keymap.set("n", "<C-M-]>", ":tablast<CR>", { silent = true, noremap = true, desc = "Move to last tab" })
keymap.set("n", "<C-M-[>", ":tabfirst<CR>", { silent = true, noremap = true, desc = "Move to first tab" })
keymap.set("n", "<M-{>", ":tabmove -1<CR>", { silent = true, noremap = true, desc = "Move tab to the left" })
keymap.set("n", "<M-}>", ":tabmove +1<CR>", { silent = true, noremap = true, desc = "Move tab to the right" })

--------------------------------------------------------------------------------
-- Window
--------------------------------------------------------------------------------
-- Window Navigation
-- keymap.set("n", "<C-Left>", "<C-w>h", options) -- move cursor to "left" window
-- keymap.set("n", "<C-Down>", "<C-w>j", options) -- move cursor to "bottom" window
-- keymap.set("n", "<C-Up>", "<C-w>k", options) -- move cursor to "top" window
-- keymap.set("n", "<C-Right>", "<C-w>l", options) -- move cursor to "right" window

-- move cursor to the first or last window
-- ctrl-(alt|option)-h | ctrl-alt-l
for _, k in pairs({ "h", "l" }) do
    keymap.set("n", "<C-M-" .. k .. ">", "<C-w>999" .. k .. "<ESC>", { silent = true, noremap = true })
end

--------------------------------------------------------------------------------
-- Full window
--------------------------------------------------------------------------------
for _, k in pairs({ "<leader>wf", "<leader>M" }) do
    keymap.set("n", k, "<C-w>| <C-w>_", {
        silent = true,
        noremap = true,
        desc = "Max out the window width and height",
    })
end

--------------------------------------------------------------------------------
-- Resize window (Ctrl-<Arrow_Keys>)
--------------------------------------------------------------------------------
keymap.set("n", "<C-Up>", ":resize +5<CR>", options) -- " Up
keymap.set("n", "<C-Down>", ":resize -5<CR>", options) -- " Down
keymap.set("n", "<C-Left>", ":vertical resize -5<CR>", options) -- " Left
keymap.set("n", "<C-Right>", ":vertical resize +5<CR>", options) -- " Right

--------------------------------------------------------------------------------
-- Terminal
--------------------------------------------------------------------------------
keymap.set("n", "$$", ":terminal<CR>A", options)
keymap.set("n", "$-", ":split<CR>:terminal<CR>A", options)
keymap.set("n", "$|", ":vsplit<CR>:terminal<CR>A", options)
keymap.set("n", "<leader><tab>$", ":tabnew<CR>:terminal<CR>A", options)

-- Terminal navigation
-- keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", options)
-- keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", options)
-- keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", options)
-- keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", options)
keymap.set("t", "<C-l>", "<C-l>", options)

--------------------------------------------------------------------------------
-- Jump tmux session
--------------------------------------------------------------------------------
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww -n '󰇘 ' -t 0 tmux-select-project<CR>", options)
keymap.set("n", "<C-g>", "<cmd>silent !tmux neww -n '󰇘 ' -t 0 lazygit<CR>", options)
keymap.set(
    "n",
    "<leader>gg",
    "<cmd>silent !tmux neww -n '󰇘 ' -t 0 lazygit<CR>",
    { silent = true, noremap = true, desc = "Open lazygit" }
)

--------------------------------------------------------------------------------
-- Misc
--------------------------------------------------------------------------------
-- do not yank with x
keymap.set("n", "x", '"_x', options)

-- Increment/decrement
keymap.set("n", "+", "<C-a>", options)
keymap.set("n", "-", "<C-x>", options)

-- delete word from the end
keymap.set("n", "dw", 'viw"_d', options)

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G", options)

keymap.set(
    "n",
    "<leader>X",
    "<cmd>!chmod +x %<CR>",
    { silent = true, noremap = true, desc = "Set the current file into executable" }
)

keymap.set("n", "<leader>;", "<cmd>so %<CR>", { silent = true, noremap = true, desc = "Reload nvim.config" })
keymap.set(
    "n",
    "<space>x",
    "<cmd>put=system(getline('.'))<CR>",
    { silent = true, noremap = true, desc = "Execute current line and put the results below" }
)

-- replace word under cursor across entire buffer
keymap.set(
    "n",
    "<leader>rw",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { silent = true, noremap = true, desc = "Replace word under cursor in entire buffer" }
)

--------------------------------------------------------------------------------
-- ...
--------------------------------------------------------------------------------
keymap.set("n", "<space>et", function()
    vim.cmd("silent! %s/\\(.*\\)=.*/\\1={{ .ENV.\\1 }}/g")
    vim.cmd("silent! sort u")
end, { silent = true, noremap = true, desc = "Convert .env.template for eFishery" })
