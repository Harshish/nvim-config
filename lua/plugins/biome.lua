-- Biome for repos with biome.json; prettier only where a prettier config exists.
vim.g.lazyvim_prettier_needs_config = true

local fts = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" }

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(fts) do
        opts.formatters_by_ft[ft] = { "biome", "prettier", stop_after_first = true }
      end
      opts.formatters = opts.formatters or {}
      -- only run biome when a biome.json is found up the tree
      opts.formatters.biome = { require_cwd = true }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- lint diagnostics + code actions; uses node_modules/.bin/biome when present
        biome = { mason = false },
      },
    },
  },
}
