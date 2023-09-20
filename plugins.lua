local plugins = {
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
    },
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          local present, null_ls = pcall(require, "null-ls")

          if not present then
            return
          end

          local b = null_ls.builtins

          local sources = {

            -- webdev stuff
            b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
            b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

            -- Lua
            b.formatting.stylua,

            -- cpp
            b.formatting.clang_format,
          }

          null_ls.setup {
            debug = true,
            sources = sources,
          }
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"

      -- require "custom.configs.lspconfig"
      local on_attach = require("plugins.configs.lspconfig").on_attach
      local capabilities = require("plugins.configs.lspconfig").capabilities
      local lspconfig = require("lspconfig")

      -- if you just want default config for the servers then put them in a table
      local servers = { "html", "cssls", "tsserver", "clangd" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      -- -- rust setup
      -- lspconfig.rust_analyzer.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   filetypes = {"rust"},
      --   root_dir = lspconfig.util.root_pattern("Cargo.toml"),
      --   settings = {
      --     ['rust_analyzer'] = {
      --       cargo = {
      --         allFeatures = true,
      --       },
      --     },
      --   },
      -- })

      -- lspconfig.pyright.setup { blabla}
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "prettier",

        -- c/cpp stuff
        "clangd",
        "clang-format",

        "rust-analyzer",
      },
    },
  },
  
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "markdown",
        "markdown_inline",
      },
      indent = {
        enable = true,
        -- disable = {
        --   "python"
        -- },
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        enable = true,
      },

      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "jackMort/ChatGPT.nvim",
    -- event = "VeryLazy",
    config = function()
      require("chatgpt").setup {
        api_key_cmd = "echo $OPENAI_API_KEY",
        openai_params = {
          model = "gpt-4",
        },
        predefined_chat_gpt_prompts =
        "https://raw.githubusercontent.com/zees-dev/awesome-chatgpt-prompts/main/prompts.csv",
      }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    lazy = false,
  },

  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
  },

  {
    "kdheepak/lazygit.nvim",
        dependencies =  {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").load_extension("lazygit")
    end,
    lazy = false,
  },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      local on_attach = require("plugins.configs.lspconfig").on_attach
      local capabilities = require("plugins.configs.lspconfig").capabilities
      local options = {
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      }
      return options
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeOpen" },
  },

  {
    "Shatur/neovim-session-manager",
    lazy = false,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    -- opts = {
    --   suggestion = {
    --     auto_trigger = true,
    --     debounce = 150,
    --     keymap = {
    --       accept = "<C-l>",
    --       accept_word = false,
    --       accept_line = false,
    --       next = "<C-.>",
    --       prev = "<C-,>",
    --       dismiss = "<C/>",
    --     },
    --   },
    -- },
    opts = {
      suggestion = {
        enable = false,
      },
      panel = {
        enable = false,
      },
    },
  },

  -- override nvim-cmp to integrate copilot
  -- https://gist.github.com/ianchesal/93ba7897f81618ca79af01bc413d0713
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = {
      sources = {
        { name = "nvim_lsp", group_index = 2 },
        { name = "copilot",  group_index = 2 },
        { name = "luasnip",  group_index = 2 },
        { name = "buffer",   group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path",     group_index = 2 },
      },
    },
  },

  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    lazy = false,
    config = function()
      require("leap").add_default_mappings()
    end,
  },

}
return plugins
