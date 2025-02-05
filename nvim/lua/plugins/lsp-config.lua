-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>fd', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>df', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gl', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Lsp colors diagnostics
vim.cmd [[
  highlight! DiagnosticLineNrError guibg=none guifg=#FF0000 gui=bold,italic
  highlight! DiagnosticLineNrWarn guibg=none guifg=#FFA500 gui=bold,italic
  highlight! DiagnosticLineNrInfo guibg=none guifg=#00FFFF gui=bold,italic
  highlight! DiagnosticLineNrHint guibg=none guifg=#0000FF gui=bold,italic

  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]


local signs = { Error = "x", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.cmd[[hi CmpItemMenu guifg=#565f89 gui=italic]]
vim.cmd[[
hi DiagnosticUnderlineError cterm=undercurl gui=undercurl guisp=#db4b4b
hi DiagnosticUnderlineWarn cterm=undercurl gui=underline,italic guisp=#e0af68
hi DiagnosticUnderlineInfo cterm=undercurl gui=underline,italic guisp=#0db9d7
hi DiagnosticUnderlineHint cterm=undercurl gui=underline,italic guisp=#1abc9c
]]


vim.cmd[[hi CmpItemMenu guifg=#565f89 gui=italic]]
vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true,
  --[[
  virtual_text = {
    prefix = '●', -- Could be '●', '▎', 'x'
  }
  --]]
})

return {
        'neovim/nvim-lspconfig',
        dependences = {'saghen/blink.cmp'},
config = function ()

---------------------------
local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}
-- To instead override globally
-- LSP settings (for overriding per client)

-- Do not forget to use the on_attach function
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end


-- Completion 
local capabilities = require('blink.cmp').get_lsp_capabilities()
require('lspconfig')['pyright'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = function() return vim.loop.cwd() end,
}
require('lspconfig')['csharp_ls'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
require('lspconfig')['clangd'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
require('lspconfig')['bashls'].setup {
  capabilities = capabilities,
    cmd = {"texlab"},
  on_attach = on_attach,
    filetypes = {"tex", "bib", "sty"},
}
require('lspconfig')['texlab'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
--[[
require('lspconfig')['ltex'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
--]]
require('lspconfig')['html'].setup {
  capabilities = capabilities,
    filetypes = { "css", "php","html", "javascript", "blade"},
  on_attach = on_attach,
}
--require('lspconfig')['ts_ls'].setup {
--  capabilities = capabilities,
--  on_attach = on_attach,
--  -- Para el root directory
--  root_dir = function() return vim.loop.cwd() end,
--  -- filetypes = {"html"}
--}
require('lspconfig')['lua_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
require('lspconfig')['vimls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
require('lspconfig')['sqls'].setup {
  capabilities = capabilities,
  root_dir = function() return vim.loop.cwd() end,
  on_attach = on_attach,
  -- root_dir = function() return vim.loop.cwd() end,
}
require('lspconfig')['matlab_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = function() return vim.loop.cwd() end,
}
--[[
require('lspconfig')['jdtls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = function() return vim.loop.cwd() end,
}
--]]
require('lspconfig')['cssls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
require('lspconfig')['prolog_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
require('lspconfig')['phpactor'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
require('lspconfig')['tailwindcss'].setup {
  capabilities = capabilities,
  root_dir = function() return vim.loop.cwd() end,
  on_attach = on_attach,
}
require('lspconfig')['stimulus_ls'].setup {
  capabilities = capabilities,
  -- root_dir = function() return vim.loop.cwd() end,
  on_attach = on_attach,
}
require('lspconfig')['emmet_language_server'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact","blade", "php" },
  -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
  -- **Note:** only the options listed in the table are supported.
  init_options = {
    ---@type table<string, string>
    includeLanguages = {},
    --- @type string[]
    excludeLanguages = {},
    --- @type string[]
    extensionsPath = {},
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences = {},
    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = true,
    --- @type "always" | "never" Defaults to `"always"`
    showExpandedAbbreviation = "always",
    --- @type boolean Defaults to `false`
    showSuggestionsAsSnippets = true,
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    syntaxProfiles = {},
    --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    variables = {},
  },
}

  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end

 -- example calling setup directly for each LSP
        ---

----------------------------
-- hover
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
--
end,

}
