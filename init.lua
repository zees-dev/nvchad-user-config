-- Use this file to make changes to default Vim or Nvim configurations

lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true
    }
  }
}

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Open NvimTree
    -- require('nvim-tree.api').tree.toggle(false, true)

    -- Load previous session for the directory
    vim.cmd("SessionManager! load_current_dir_session")

    -- TODO: load symbols view for file
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    -- TODO: any hooks before exggle(false, false)
  end,
})

