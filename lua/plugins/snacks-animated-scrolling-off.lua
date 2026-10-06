return {
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = false, -- Disable scrolling animations
    },
    -- picker = {
    --   sources = {
    --     explorer = {
    --       hidden = true,  -- show dotfiles, like nvim-tree
    --       ignored = true, -- show git-ignored files (your git.ignore = false)
    --       exclude = { ".DS_Store", "thumbs.db", "node_modules", "__pycache__" },
    --     },
    --   },
    -- },
    dashboard = {
      preset = {
        header = [[                                                       
▄▄                                      ▄▄             
██                      ▀▀              ██             
████▄  ▀▀█▄ ████▄ ▄█▀▀▀ ██  ▄█▀▀▀    ▄████ ▄█▀█▄ ██ ██ 
██ ██ ▄█▀██ ██ ▀▀ ▀███▄ ██  ▀███▄    ██ ██ ██▄█▀ ██▄██ 
██ ██ ▀█▄██ ██    ▄▄▄█▀ ██▄ ▄▄▄█▀ ██ ▀████ ▀█▄▄▄  ▀█▀  
                                                       
                                                       ]],
      },
    },
  },
}
