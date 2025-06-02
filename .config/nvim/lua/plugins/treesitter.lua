return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
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
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
    -- note: need to use .configs setup function
    config = function (_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end
  }
}
