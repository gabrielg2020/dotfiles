return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        enabled = true,
        default_prompt = "➤ ",
        win_options = {
          winblend = 10,
        },
      },
      select = {
        enabled = true,
        backend = { "fzf", "builtin"}
      },
    },
  }
}


