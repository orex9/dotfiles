-- options
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.undofile = true
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorcolumn = false
vim.o.signcolumn = "yes"
vim.o.hlsearch = false
vim.o.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.o.scrolloff = 8
vim.o.splitright = true
vim.o.splitbelow = true

-- keymaps
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>h', ':lua FzfLua.helptags()<CR>')
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostic infloating window' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', ':+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', ':+d<CR>')
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>sf', ':lua FzfLua.files({ cwd = vim.fn.expand("%:h") })<CR>')
vim.keymap.set('n', '<leader>sb', ':lua FzfLua.buffers()<CR>')
vim.keymap.set('n', '<leader>sg', ':lua FzfLua.live_grep()<CR>')
vim.keymap.set('n', '<leader>/', ':lua FzfLua.lgrep_curbuf()<CR>')
vim.keymap.set('n', 'gd', ':lua FzfLua.lsp_definitions()<CR>')
vim.keymap.set('n', 'gr', ':lua FzfLua.lsp_references()<CR>')
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>ds', ':lua FzfLua.lsp_document_symbols()<CR>')

-- plugins
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ src = "https://github.com/scottmckendry/cyberdream.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/nvim-mini/mini.cursorword" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/Saghen/blink.cmp" },
})

-- plugins setup and configurations
require "gitsigns".setup()
require "mini.pairs".setup()
require "mason".setup()
require "mini.cursorword".setup()
require "fzf-lua".setup()
require "nvim-treesitter.configs".setup({
	ensure_installed = { "go", "javascript", "json", "lua", "python", "typescript", "bash" },
	highlight = { enable = true }
})

-- blink.cmp
require "blink.cmp".setup({
	fuzzy      = {
		sorts = {
			'exact',
			'score',
			'sort_text',
			'label'
		},
	},
	cmdline    = { enabled = false },
	signature  = { enabled = true },
	sources    = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	completion = {
		keyword = { range = 'full' },
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
	},
})
vim.lsp.config('*', {
	capabilities = require('blink.cmp').get_lsp_capabilities(),
})
vim.lsp.enable({ "lua_ls", "gopls", "vtsls" })

vim.cmd("colorscheme cyberdream")
vim.cmd(":hi statusline guibg=NONE")


-- Functions
-- golang format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
		vim.lsp.buf.format({ async = true })
	end
})

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function() vim.hl.on_yank() end,
})
