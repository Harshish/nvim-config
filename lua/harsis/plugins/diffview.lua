return {
	"sindrets/diffview.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" }, -- diffview.nvim requires plenary.nvim
	config = function()
		-- Optional: Configure diffview.nvim
		require("diffview").setup({
			-- Add your custom configuration here, if needed
			enhanced_diff_hl = true, -- Enable enhanced diff highlighting
			use_icons = true, -- Use icons in the UI
			file_panel = {
				win_config = {
					position = "left", -- File panel position
				},
			},
		})
	end,
	keys = {
		{ "<leader>do", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
		{ "<leader>dc", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
		{ "<leader>dh", "<cmd>DiffviewFileHistory<CR>", desc = "Open File History" },
	},
}
