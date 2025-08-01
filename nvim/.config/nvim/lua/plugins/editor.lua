return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "mbbill/undotree",
    keys = {
      { "<leader>U", "<cmd>UndotreeToggle<CR>", desc = "Undotree toggle" },
    },
  },

  {
    "Wansmer/treesj",
    keys = {
      { "<leader>cj", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false },
  },

  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          multi_line = false,
          highlight = { backdrop = false },
          char_actions = function()
            return {
              [";"] = "next", -- set to `right` to always go right
              [","] = "prev", -- set to `left` to always go left
            }
          end,
        },
      },
    },
    keys = function()
      -- stylua: ignore
      return {
        { "m", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
        { "<C-t>", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
      }
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = "   ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
      },
      pickers = {
        find_files = {
          previewer = false,
        },
      },
    },
    keys = {
      -- disable the keymap to grep files
      { "<leader>/", false },
    },
  },

  {
    "folke/trouble.nvim",
    opts = {
      focus = true,
      modes = {
        symbols = {
          focus = true,
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
    },
  },

  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    lazy = false,
    enabled = false,
    opts = {
      disable_mouse = false,
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>m", group = "CMake", icon = { icon = " ", color = "blue" } },
        { "<leader>a", group = "ai", icon = { icon = " ", color = "green" } },
      },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        reverse = false,
        sources = {
          files = {
            layout = { preview = false },
            hidden = true,
          },
          -- explorer (snacks picker)
          explorer = {
            hidden = true,
            win = {
              list = {
                keys = {
                  ["o"] = "confirm",
                  ["O"] = "explorer_open", -- open with system application
                },
              },
            },
          },
        },
      },
    },
  },

  -- yazi
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<leader>e", mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
      { "<leader>E", "<cmd>Yazi cwd<cr>", desc = "Open yazi in current working directory" },
      { "<tab>", "" },
    },
    opts = {
      open_for_directories = true,
      highlight_hovered_buffers_in_same_directory = false,
      keymaps = {
        cycle_open_buffers = false,
      },
    },
  },
}
