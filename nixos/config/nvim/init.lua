vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local config = require("nvim-treesitter.configs")
config.setup({
  highlight={
    enable=true
  }
})

require("lualine").setup({
  options={
    theme="dracula"
  }
})

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({
  autostart=true
})

require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
      }
    }
  }
}
require("telescope").load_extension("ui-select")

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<C-c>", ":Neotree reveal toggle<CR>")
vim.g.material_style = "palenight"
vim.cmd("colorscheme material")
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='lightgreen' })
vim.api.nvim_set_hl(0, 'LineNr', { fg='green' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='lightgreen' })
