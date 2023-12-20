-- package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local icons = require('config').icons
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- error = icons.diagnostics.Error,
-- warn = icons.diagnostics.Warn,
-- info = icons.diagnostics.Info,
-- hint = icons.diagnostics.Hint,
vim.diagnostic.config({
  signs = {
    --support diagnostic severity / diagnostic type name
    text = {
      ['WARN'] = icons.diagnostics.Warn,
      ['INFO'] = icons.diagnostics.Info,
      ['HINT'] = icons.diagnostics.Hint,
      ['ERROR'] = icons.diagnostics.Error,
    },
  },
})

-- plugin
require('lazy').setup('plugins')
