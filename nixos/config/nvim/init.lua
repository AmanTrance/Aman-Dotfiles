vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local config = require("nvim-treesitter.configs")

config.setup({
	sync_install = true,
	highlight = {
		enable = true,
	},
})

require("lualine").setup({
	options = {
		theme = "dracula",
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

lspconfig.hls.setup({
	autostart = true;
	capabilities = capabilities
})

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

vim.g.material_style = "palenight"
vim.cmd("colorscheme material")

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
