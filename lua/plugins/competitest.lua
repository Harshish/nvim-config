return {
  "xeluxee/competitest.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  config = function()
    local cp = "/Users/harsis/Documents/Workspace/CP"
    require("competitest").setup({
      received_files_extension = "py",
      received_problems_path = cp .. "/$(JUDGE)/$(CONTEST)/$(PROBLEM).$(FEXT)",
      template_file = { py = cp .. "/template.py" },
      received_contests_problems_path = "$(PROBLEM).$(FEXT)",
      run_command = {
        python = { exec = "pypy3", args = { "$(FNAME)" } },
      },
    })
    vim.keymap.set("n", "<leader>cpr", "<cmd>CompetiTest run<cr>")
    vim.keymap.set("n", "<leader>cpp", "<cmd>CompetiTest receive problem<cr>")
    vim.keymap.set("n", "<leader>cpc", "<cmd>CompetiTest receive contest<cr>")
    vim.keymap.set("n", "<leader>cpa", "<cmd>CompetiTest add_testcase<cr>")
  end,
}
