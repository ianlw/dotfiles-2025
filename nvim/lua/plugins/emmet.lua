return {
        "olrtg/nvim-emmet",
        ft = { "html", "javascript", "typescript", "typescriptreact", "vue", "svelte", "css", "scss", "postcss" },  -- Archivos relevantes
        config = function()
            vim.keymap.set({"n", "v"}, '<leader>xe',
                           require('nvim-emmet').wrap_with_abbreviation)
        end
    }
