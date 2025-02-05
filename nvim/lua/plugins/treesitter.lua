return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
vim.cmd [[nnoremap gf <C-W>gf]]
vim.cmd [[ autocmd BufRead,BufNewFile *.asm set filetype=nasm ]] -- latex lsp
vim.cmd [[ autocmd VimEnter * TSEnable highlight ]]
vim.cmd [[ autocmd VimEnter * TSEnable indent ]]
vim.cmd [[ autocmd VimEnter * TSEnable ts_context_commentstring ]]
    end,
}
