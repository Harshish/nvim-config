return {
	"Exafunction/codeium.nvim", -- Codeium plugin repo
	event = "InsertEnter", -- Lazy-load when entering insert mode
	config = function()
		-- Try to load Codeium safely
		local ok, codeium = pcall(require, "codeium")
		if not ok then
			vim.notify("Codeium not found!", vim.log.levels.ERROR)
			return
		end

		-- Track global enable state
		_G.codeium_enabled = true

		-- Setup function
		local function setup_codeium(enable)
			codeium.setup({
				enable_cmp_source = false,
				virtual_text = {
					enabled = enable,
					manual = false,
					filetypes = {},
					default_filetype_enabled = true,
					idle_delay = 75,
					virtual_text_priority = 65535,
					map_keys = true,
					accept_fallback = nil,
					key_bindings = {
						accept = "<Tab>",
						accept_word = false,
						accept_line = false,
						clear = false,
						next = "<]>",
						prev = "<[>",
					},
				},
			})
		end

		-- Setup on first load
		setup_codeium(_G.codeium_enabled)

		-- Toggle function
		function _G.toggle_codeium()
			_G.codeium_enabled = not _G.codeium_enabled
			setup_codeium(_G.codeium_enabled)

			if _G.codeium_enabled then
				vim.notify("✅ Codeium enabled", vim.log.levels.INFO)
			else
				vim.notify("❌ Codeium disabled", vim.log.levels.WARN)
			end
		end

		-- Optional: map a key to toggle Codeium
		vim.keymap.set("n", "<leader>tc", toggle_codeium, { desc = "Toggle Codeium" })

		-- Integrate with lualine (optional)
		local status_lualine, lualine = pcall(require, "lualine")
		if status_lualine then
			local status_cvt, codeium_virtual_text = pcall(require, "codeium.virtual_text")
			if status_cvt then
				codeium_virtual_text.set_statusbar_refresh(function()
					lualine.refresh()
				end)
			end
		end
	end,
}
