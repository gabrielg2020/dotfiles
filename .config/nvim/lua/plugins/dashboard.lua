return {
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
    config = function ()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        [[                  *     .--.        ]],
        [[                       / /  `       ]],
        [[      +               | |           ]],
        [[             '         \ \__,       ]],
        [[         *          +   '--'  *     ]],
        [[             +   /\                 ]],
        [[+              .'  '.   *           ]],
        [[       *      /======\      +       ]],
        [[             ;:.  _   ;             ]],
        [[             |:. (_)  |             ]],
        [[             |:.  _   |             ]],
        [[   +         |:. (_)  |             ]],
        [[             ;:.      ;             ]],
        [[           .' \:.    / `.           ]],
        [[          / .-'':._.'`-. \          ]],
        [[          |/    /||\    \|          ]],
        [[        _..--"""````"""--.._        ]],
        [[  _.-'``                    ``'-._  ]],
        [[-'                                '-]],
      }

      dashboard.section.buttons.val = {
        dashboard.button("p", "Projects", ":Telescope repo list<CR>"),
        dashboard.button("n", "NeoVim Config", ":Telescope find_files cwd=~/dotfiles/.config/nvim<CR>"),
        dashboard.button("q", "Quit", ":qa<CR>"),
      }

      local function footer()
        local total_plugins = require("lazy").stats().count

        return total_plugins .. " plugins"
      end
      dashboard.section.footer.val = footer()

      dashboard.opts.layout[1].val = 8
      alpha.setup(dashboard.config)

      -- keymaps
      vim.keymap.set('n', '<leader><BS>', ":Alpha<CR>", {desc="Goto Dashboard"})
    end
  }
}
