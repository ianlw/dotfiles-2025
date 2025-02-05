return {
  'saghen/blink.cmp',
    
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',
    lazy = true,
  -- use a release tag to download pre-built binaries
  version = '*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
  -- Disable for some filetypes

  completion = {
 --list = {
   --       selection = "auto_insert",
     --   },

    -- 'prefix' will fuzzy match on the text before the cursor
    -- 'full' will fuzzy match on the text before *and* after the cursor
    -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
    keyword = { range = 'full' },

    -- Disable auto brackets
    -- NOTE: some LSPs may add auto brackets themselves anyway
    accept = { auto_brackets = { enabled = true }, },

    -- Don't select by default, auto insert on selection    
    list = { selection = { preselect = false, auto_insert = false } },
    -- or set either per mode via a function
    --list = { selection = { preselect = function(ctx) return ctx.mode ~= 'cmdline' end } },

    menu = {
      -- Don't automatically show the completion menu
      auto_show = true,
                border = "rounded",
          draw = { gap = 2 },
winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',

      -- nvim-cmp style menu
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon" }
        },
      }
    },

    -- Show documentation when selecting a completion item
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
          },
        },

    -- Display a preview of the selected item on the current line
    ghost_text = { enabled = true },
  },

        keymap = {
  -- set to 'none' to disable the 'default' preset
  preset = 'default',

  ['<CR>'] = { 'accept', 'fallback' },
  ['<Up>'] = { 'select_prev', 'fallback' },
  ['<Down>'] = { 'select_next', 'fallback' },
  ['<S-Tab>'] = { 'select_prev', 'fallback' },
  ['<Tab>'] = { 'select_next', 'fallback' },
  ['<C-k>'] = { 'show', 'show_documentation', 'hide_documentation' },

  -- disable a keymap from the preset
  ['<C-e>'] = {},
  -- show with a list of providers
  ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },

  -- control whether the next command will be run when using a function
  ['<C-n>'] = { 
    function(cmp)
      if some_condition then return end -- runs the next command
      return true -- doesn't run the next command
    end,
    'select_next'
  },

  -- optionally, separate cmdline keymaps
  -- cmdline = {}
},


  sources = {
    -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
    default = {'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
     providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,},},
    -- Disable cmdline completions
    --cmdline = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  -- Use a preset for snippets, check the snippets documentation for more information
  snippets = { preset = 'default'},

  -- Experimental signature help support
  signature = { enabled = true }
},
  opts_extend = { "sources.default" }
}
