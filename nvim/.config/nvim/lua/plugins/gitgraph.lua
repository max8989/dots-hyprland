return {
  "isakbm/gitgraph.nvim",
  lazy = true,
  dependencies = {
    "sindrets/diffview.nvim",
  },
  keys = {
    {
      "<leader>gl",
      function()
        require("gitgraph").draw({}, { all = true, max_count = 5000 })
      end,
      desc = "Git graph - all branches",
    },
    {
      "<leader>gL",
      function()
        require("gitgraph").draw({}, { max_count = 1000 })
      end,
      desc = "Git graph - current branch",
    },
    {
      "<leader>gf",
      function()
        local file = vim.fn.expand("%")
        if file ~= "" then
          require("gitgraph").draw({}, { all = true, max_count = 1000 }, file)
        else
          print("No file in current buffer")
        end
      end,
      desc = "Git graph - current file history",
    },
    {
      "<leader>gv",
      function()
        require("gitgraph").draw({}, { max_count = 50 })
      end,
      desc = "Git graph - recent commits",
    },
  },
  opts = {
    symbols = {
      merge_commit = "M",
      commit = "*",
    },
    format = {
      timestamp = "%H:%M:%S %d-%m-%Y",
      fields = { "hash", "timestamp", "author", "branch_name", "tag" },
    },
    hooks = {
      -- Press Enter on a commit to open diffview
      on_select_commit = function(commit)
        vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
      end,
      -- Visual select commits and press Enter to see range diff
      on_select_range_commit = function(from, to)
        vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
      end,
    },
  },
}
