vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  "marko-cerovac/material.nvim",
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
	{
		"nvim-treesitter/nvim-treesitter", build=":TSUpdate"
	},
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "williamboman/mason.nvim"
  },
  {
    "williamboman/mason-lspconfig.nvim"
  },
  {
    "neovim/nvim-lspconfig"
  },
  {
   "nvim-telescope/telescope-ui-select.nvim"
  }
})

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed={"lua", "rust", "go", "typescript", "javascript", "ruby", "python", "kotlin", "haskell", "c", "css", "html", "dockerfile", "sql", "yaml", "json"},
  sync_install=false,
  auto_install=true,
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

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer", "bashls", "ast_grep", "tailwindcss", "dockerls", "gopls", "graphql", "hls", "html", "eslint",
    "jsonls", "pylyzer", "ruby_lsp", "sqls", "yamlls" },
})

local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup({
  settings = {
    ['rust-analyzer'] = {},
  },
})
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
vim.g.material_style = "darker"
vim.cmd("colorscheme material")
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='lightgreen' })
vim.api.nvim_set_hl(0, 'LineNr', { fg='green' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='lightgreen' })
