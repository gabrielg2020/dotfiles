return {
  {
    "mfussenegger/nvim-lint",
    dependencies = {
      "mason-org/mason.nvim",
    },
    config = function ()
      local lint = require("lint")

      lint.linters_by_ft = {
        lua = {"luacheck"},
        go = {"golangcilint"},
        typescript = {"biomejs"},
        javascript = {"biomejs"},
      }

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          source = "if_many",
          insert_mode = false,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Run lint on save a text change
      vim.api.nvim_create_autocmd({"BufWritePost", "BufReadPost", "InsertLeave"}, {
        callback = function ()
          lint.try_lint()
        end,
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>ll", function ()
        lint.try_lint()
      end, {desc = "Trigger linting"})
    end
  }
}
