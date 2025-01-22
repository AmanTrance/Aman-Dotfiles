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
vim.opt.swapfile = false
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
	"marko-cerovac/material.nvim",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvimtools/none-ls.nvim",
	},
	{
		"nvimdev/dashboard-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"hrsh7th/nvim-cmp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
})

local visualConfigs = require("material")

vim.g.material_style = "palenight"

visualConfigs.setup({
	styles = {
		keywords = { bold = true },
		variables = { bold = true },
	},
})

vim.cmd("colorscheme material")

local treeSitterConfig = require("nvim-treesitter.configs")

treeSitterConfig.setup({
	ensure_installed = {
		"lua",
		"rust",
		"go",
		"typescript",
		"ocaml",
		"javascript",
		"ruby",
		"python",
		"kotlin",
		"haskell",
		"c",
		"css",
		"html",
		"dockerfile",
		"sql",
		"yaml",
		"json",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("lualine").setup({
	options = {
		theme = "dracula",
	},
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"bashls",
		"ast_grep",
		"tailwindcss",
		"dockerls",
		"gopls",
		"graphql",
		"hls",
		"html",
		"eslint",
		"jsonls",
		"pylyzer",
		"ruby_lsp",
		"sqls",
		"yamlls",
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
	autostart = true,
	settings = {
		["rust_analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				runBuildScripts = true,
			},
			checkOnSave = {
				allFeatures = true,
				command = "clippy",
				extraArgs = "--no-deps",
			},
		},
	},
	capabilities = capabilities,
})

lspconfig.lua_ls.setup({
	autostart = true,
	capabilities = capabilities,
})

lspconfig.ocamllsp.setup({
	autostart = true,
	capabilities = capabilities,
})

lspconfig.ruby_lsp.setup({
	autostart = true,
	capabilities = capabilities,
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.ocamlformat,
	},
})

local dashboard = require("dashboard")

dashboard.setup({
	theme = "hyper",
	config = {
		week_header = { enable = true },
	},
})

local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})

require("telescope").load_extension("ui-select")

vim.keymap.set("n", "F", vim.lsp.buf.format, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "A", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "G", vim.lsp.buf.definition, {})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-f>", builtin.find_files, {})
vim.keymap.set("n", "<C-g>", builtin.live_grep, {})
vim.keymap.set("n", "<C-c>", ":Neotree reveal toggle<CR>", {})
vim.keymap.set("n", "<C-b>", function()
	builtin.buffers({ sort_mru = true, ignore_current_buffer = false })
end, {})

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "pink" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "lightgreen" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "pink" })
