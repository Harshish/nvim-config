return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- show filtered items dimmed
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false, -- OS-hidden files
        },
      },
    },
  },
}
