return  {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "javascript", "hyprlang", "html", "css", "c_sharp", "razor" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  }
}

