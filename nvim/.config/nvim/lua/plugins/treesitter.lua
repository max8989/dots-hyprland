return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'main',
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local parsers = {
      "c", "lua", "vim", "vimdoc", "query",
      "markdown", "markdown_inline", "mermaid",
      "javascript", "hyprlang", "html", "css",
      "c_sharp", "razor",
    }

    require("nvim-treesitter").install(parsers)

    local filetypes = {
      "c", "lua", "vim", "help", "query",
      "markdown", "mermaid",
      "javascript", "hyprlang", "html", "css",
      "cs", "razor",
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"
        vim.wo.foldlevel = 99
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
