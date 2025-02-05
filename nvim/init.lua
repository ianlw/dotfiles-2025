-- basic settings 
require('ian.core.settings')
require('ian.core.keymaps')
require('ian.core.keymaps-compiler')

-- lazy package manager
require('config.lazy')

-- load colorscheme
vim.cmd.colorscheme "tokyonight"
require('ian.core.colors')




-- Status line
--require('ian.plugins.staline')
