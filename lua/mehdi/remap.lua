vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.api.nvim_set_keymap('n', '<leader>ft', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFocus<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<S-f>', ':lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sw', '<C-w>w', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>vrr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>vrn', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ss', ':lua SplitPrompt()<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, silent = true })            -- Normal mode
vim.keymap.set("v", "<C-_>", "gc", { remap = true, silent = true })             -- Visual mode
vim.keymap.set("n", "<leader>dq", ":DBUIToggle<CR>", { desc = "Toggle DB UI" }) -- Toggle DB UI
vim.api.nvim_set_keymap("n", "<leader>ji", ":lua JumpToNearestClosingBracketAndInsert()<CR>",
	{ noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>jo", ":lua JumpOutsideClosingBracket()<CR>",
	{ noremap = true, silent = true })
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<leader>bp', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>du', require 'dapui'.toggle)
vim.api.nvim_set_keymap("x", "<leader>s(", ":lua (surround_word_with)('()')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<leader>s[", ":lua surround_word_with('[]')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<leader>s{", ":lua surround_word_with('{}')<CR>", { noremap = true, silent = true })
