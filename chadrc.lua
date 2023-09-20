-- Use this file to make changes to plugins or nvchad option

---@type ChadrcConfig
local M = {}
M.ui = { theme = "ayu_dark" }
M.plugins = "custom.plugins"
M.mappings = {
  disabled = {
    -- ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    ["<leader>v"] = "",
    ["<leader>h"] = "",
  },

  general = {
    i = {
      ["<C-s>"] = { "<cmd>w<cr>" ,"Save file (insert mode)" },
      ["<C-q>"] = { "<cmd>wq<cr>" ,"Save file and quit (insert mode)" },
    },
    n = {
      -- ["<leader>F"] = {
      --   function()
      --   --   --[[ vim.g.rustfmt_autosave = 0 ]]
      --     lsp.formatting.format_on_save.enabled = false
      --   end,
      --   "Toggle formatting",
      -- },
      ["<C-s>"] = { "<cmd>w<cr>" ,"Save file (insert mode)" },
      ["<C-q>"] = { "<cmd>wq<cr>" ,"Save file and quit (insert mode)" },
      ["|"] = { "<cmd>vsplit<cr>", "Vertical Split" },
      ["\\"] = { "<cmd>split<cr>", "Horizontal Split" },
      ["<C-a>"] = { "ggVG", "Highlight all text" },
    },
    v = {
      ["<S-Tab>"] = { "<gv", desc = "Unindent line" },
      ["<Tab>"] = { ">gv", desc = "Indent line" },
      ["/"] = { "y/<C-R>\"<CR>", desc = "Copy highlighted text" },
      -- ["<leader>r"] = { "y%s//\r/gc<CR>", desc = "Find and replace" },
    },
  },

  session_manager = {
    n = {
      ["<leader>Sl"] = { "<cmd>SessionManager! load_last_session<cr>", desc = "Load last session" },
      ["<leader>Ss"] = { "<cmd>SessionManager! save_current_session<cr>", desc = "Save this session" },
      ["<leader>Sd"] = { "<cmd>SessionManager! delete_session<cr>", desc = "Delete session" },
      ["<leader>Sf"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" },
      ["<leader>S."] = { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" },
    },
  },

  lazygit = {
    n = {
      ["<leader>gg"] = { "<cmd> LazyGit<CR>", "Toggle lazygit" },
    },
  },

  nvterm = {
    i = {
      -- improved terminal navigation
      ["<C-h>"] = { "<cmd>wincmd h<cr>", desc = "Terminal left window navigation" },
      ["<C-j>"] = { "<cmd>wincmd j<cr>", desc = "Terminal down window navigation" },
      ["<C-k>"] = { "<cmd>wincmd k<cr>", desc = "Terminal up window navigation" },
      ["<C-l>"] = { "<cmd>wincmd l<cr>", desc = "Terminal right window navigation" },
    },
    -- toggle in terminal mode
    t = {
      ["<F7>"] = {
        function() require("nvterm.terminal").toggle "float" end,
        "Toggle floating term",
      },
      -- improved terminal navigation
      ["<C-h>"] = { "<cmd>wincmd h<cr>", desc = "Terminal left window navigation" },
      ["<C-j>"] = { "<cmd>wincmd j<cr>", desc = "Terminal down window navigation" },
      ["<C-k>"] = { "<cmd>wincmd k<cr>", desc = "Terminal up window navigation" },
      ["<C-l>"] = { "<cmd>wincmd l<cr>", desc = "Terminal right window navigation" },
      ["<esc>"] = { "<esc><C-\\><C-n>", desc = "Escape terminal mode" },
      ["<esc><esc>"] = { "<cmd> :q <cr>", desc = "Exit terminal mode" },
    },

    -- toggle in normal mode
    n = {
      ["<F7>"] = {
        function() require("nvterm.terminal").toggle "float" end,
        "New horizontal term",
      },
    },
  },

  tabufline = {
    n = {
      ["<"] = {
        function() require("nvchad.tabufline").move_buf(-1) end,
        "Move prev buffer",
      },
      [">"] = {
        function() require("nvchad.tabufline").move_buf(1) end,
        "Move next buffer",
      },
    }
  }
}
return M
