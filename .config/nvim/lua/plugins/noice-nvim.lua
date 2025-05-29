return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      override = {
        ["vim.lsp.util.convert_inputs_to_markdown_line"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }
}
