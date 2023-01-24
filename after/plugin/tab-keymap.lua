-- local keymap = vim.api.nvim_set_keymap
-- local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local opts = {}

-- Move to previous/next
keymap("n", "<M-[>", ":BufferPrevious<CR>", opts)
keymap("n", "<M-]>", ":BufferNext<CR>", opts)

-- Re-order to previous/next
keymap("n", "<M-{>", ":BufferMovePrevious<CR>", opts)
keymap("n", "<M-}>", ":BufferMoveNext<CR>", opts)

-- Goto buffer in position...
keymap("n", "<M-1>", ":BufferGoto 1<CR>", opts)
keymap("n", "<M-2>", ":BufferGoto 2<CR>", opts)
keymap("n", "<M-3>", ":BufferGoto 3<CR>", opts)
keymap("n", "<M-4>", ":BufferGoto 4<CR>", opts)
keymap("n", "<M-5>", ":BufferGoto 5<CR>", opts)
keymap("n", "<M-6>", ":BufferGoto 6<CR>", opts)
keymap("n", "<M-7>", ":BufferGoto 7<CR>", opts)
keymap("n", "<M-8>", ":BufferGoto 8<CR>", opts)
keymap("n", "<M-9>", ":BufferGoto 9<CR>", opts)
keymap("n", "<M-0>", ":BufferLast<CR>", opts)
-- Close buffer
-- map('n', '<M-c>', ':BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode
keymap("n", "<leader>bp", ":BufferPick<CR>", opts)

-- Buffer pin (pin tab)
keymap("n", "<leader>bP", ":BufferPin<CR>", opts)

-- Sort automatically by...
-- map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
-- map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
-- map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
