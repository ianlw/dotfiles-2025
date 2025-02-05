return {
'williamboman/mason.nvim',
dependences = {    'williamboman/mason-lspconfig.nvim', -- Completion
config = function()
require("mason").setup()
require("mason-lspconfig").setup()

end,
} 
}
