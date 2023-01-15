local options = { silent = true, noremap = true }

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", options)
vim.keymap.set("n", "<leader>xc", "<cmd>TroubleClose<cr>", options)
vim.keymap.set("n", "<leader>xr", "<cmd>TroubleRefresh<cr>", options)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", options)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", options)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", options)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", options)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", options)
