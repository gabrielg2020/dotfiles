return {
  {
    "stevearc/conform.nvim",
    config = function()
      local mason_bridge = require("mason-bridge")
      require("conform").setup({
        formatters_by_ft = mason_bridge.get_formatters(),
        formats_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })

      -- Keymaps
      vim.keymap.set({ "n", "v" }, "<leader>lf", function()
        require("conform").format({ lsp_fallback = true })
      end, { desc = "Format file" })
    end
  }
}
