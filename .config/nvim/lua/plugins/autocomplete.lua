return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- only load plugin when in INSERT mode
    dependencies = {       -- place autocomplete sources here
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),

        sources = cmp.config.sources({ -- order of priority matters here!
          { name = "nvim_lsp" },
          { name = "lazydev" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  }
}
