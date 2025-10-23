-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end
local utils = require("null-ls.utils")

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Returns true if any of the listed files exist in the root
local function has_file(files)
	local root = utils.root_pattern(unpack(files))(vim.api.nvim_buf_get_name(0))
	return root ~= nil
end

local has_prettier = function()
	return has_file({
		".prettierrc",
		".prettierrc.json",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.json5",
		".prettierrc.js",
		".prettierrc.cjs",
		"prettier.config.js",
		"prettier.config.cjs",
		".prettierrc.toml",
	})
end

local has_eslint = function()
	return has_file({
		".eslintrc.cjs",
		"eslint.config.js",
		"eslint.config.mjs",
		".eslintrc",
		".eslintrc.js",
		".eslintrc.yaml",
		".eslintrc.yml",
		".eslintrc.json",
	})
end

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		-- JavaScript/TypeScript formatters
		formatting.prettier.with({
			filetypes = { "javascript", "typescript", "vue", "html", "css", "javascriptreact", "typescriptreact" },
			-- Optional: Align Prettier with ESLint rules
			condition = has_prettier,
		}),

		formatting.eslint_d.with({
			filetypes = { "javascript", "typescript", "vue", "html", "css", "javascriptreact", "typescriptreact" },
			command = "eslint_d",
			-- Explicitly set cwd to the project root with .eslintrc.cjs
			cwd = function()
				local root = utils.root_pattern(
					".eslintrc.cjs",
					"eslint.config.js",
					"eslint.config.mjs",
					".eslintrc",
					".eslintrc.js",
					".eslintrc.yaml",
					".eslintrc.yml",
					".eslintrc.json"
				)(vim.api.nvim_buf_get_name(0))
				return root
			end,
			-- Ensure eslint_d only runs if an ESLint config exists
			condition = has_eslint,
			extra_args = { "--fix" },
		}),

		-- Other formatters
		formatting.stylua, -- lua formatter
		formatting.black, -- python formatter
		formatting.isort, -- python formatter
		-- Linters
		diagnostics.pylint.with({
			diagnostics_postprocess = function(diagnostic)
				diagnostic.code = diagnostic.message_id
			end,
		}),
		diagnostics.eslint_d.with({
			filetypes = { "javascript", "typescript", "vue", "html", "css", "javascriptreact", "typescriptreact" },
			command = "eslint_d",
			-- Explicitly set cwd to the project root with eslint config
			cwd = function()
				local root = utils.root_pattern(
					".eslintrc.cjs",
					"eslint.config.js",
					"eslint.config.mjs",
					".eslintrc",
					".eslintrc.js",
					".eslintrc.yaml",
					".eslintrc.yml",
					".eslintrc.json"
				)(vim.api.nvim_buf_get_name(0))
				return root
			end,
			-- Ensure eslint_d only runs if an ESLint config exists
			condition = has_eslint,
		}),
	},
	-- configure format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(lsp_client)
							-- Priority: Prettier > ESLint > tsserver fallback
							-- if has_prettier() then
							-- 	return lsp_client.name == "null-ls" -- prettier
							-- elseif not has_prettier() and has_eslint() then
							-- 	return lsp_client.name == "null-ls" -- eslint_d --fix
							-- else
							-- 	return lsp_client.name == "tsserver" -- fallback only when both not present
							-- end
							return lsp_client.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
})
