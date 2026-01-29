return { "zbirenbaum/copilot.lua",
  dependencies = {
    "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
  },
    config = function()
        require("copilot").setup({

        suggestion = {
            enable =true,
            auto_trigger = true,
        },
        panel = {
            enabled = false,
        },
        filetypes = {
            markdown = true, 
            help =true,
            html = true,
            javascript = true,
            typescript = true,
            ["*"] = true,
        },
            })
              vim.keymap.set("i", '<C-CR>', function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-CR>", true, false, true), "n", false)
        end
      end, {
          silent = true,
        })
    end,

}
