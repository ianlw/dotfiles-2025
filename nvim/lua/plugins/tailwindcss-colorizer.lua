return {
  "roobert/tailwindcss-colorizer-cmp.nvim",
  -- optionally, override the default options:
        ft = { "html", "javascript", "typescript", "typescriptreact", "vue", "svelte", "css", "scss", "postcss", "tsx" },  -- Archivos relevantes
  config = function()
    require("tailwindcss-colorizer-cmp").setup({
      color_square_width = 2,
    })
  end
}
