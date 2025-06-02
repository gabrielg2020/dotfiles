return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "templ",
      "toml",
      "typescript",
      "vim",
      "xml",
      "yaml",
    }
  }
}
