return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      on_highlights = function(hl, c)
        hl.TelescopeNormal = {
          bg = c.none,
        }
        hl.TelescopeBorder = {
          bg = c.none,
        }
        hl.TelescopePromptNormal = {
          bg = c.none,
        }
        hl.TelescopePromptBorder = {
          bg = c.none,
        }
        hl.TelescopePromptTitle = {
          bg = c.none,
        }
        hl.TelescopePreviewTitle = {
          bg = c.none,
        }
        hl.TelescopeResultsTitle = {
          bg = c.none,
        }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
