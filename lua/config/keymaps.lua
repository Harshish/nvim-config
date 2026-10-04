-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("n", "<leader>tf", "<cmd>tabnew %<cr>", { desc = "Open buffer in new tab" })
map("n", "<leader>rs", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
-- your <leader>gb is LazyVim's "Git Blame Line", so branches move to <leader>go
map("n", "<leader>go", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })

-- go to definition in a split or tab
map("n", "gdv", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", { desc = "Definition (vsplit)" })
map("n", "gds", "<cmd>split | lua vim.lsp.buf.definition()<cr>", { desc = "Definition (split)" })
map("n", "gdt", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("tabedit %")
  vim.api.nvim_win_set_cursor(0, pos)
  vim.lsp.buf.definition()
end, { desc = "Definition (new tab)" })
