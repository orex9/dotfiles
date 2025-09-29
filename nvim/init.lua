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
vim.o.cursorcolumn = false
vim.o.signcolumn = "yes"
vim.o.hlsearch = false
vim.o.autoread = true
vim.opt.clipboard = "unnamedplus"


-- keymaps
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostic infloating window' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', ':+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', ':+d<CR>')
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- plugins
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ src = "https://github.com/scottmckendry/cyberdream.nvim" },
	-- { src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-mini/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/s1n7ax/nvim-window-picker" },
})


-- lsp
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

-- golang format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		-- buf_request_sync defaults to a 1000ms timeout. Depending on your
		-- machine and codebase, you may want longer. Add an additional
		-- argument after params if you find that you have to write the file
		-- twice for changes to be saved.
		-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end
})

vim.cmd [[set completeopt+=menuone,noselect,popup]]

vim.lsp.enable({ "lua_ls", "gopls" })
-- plugins setup and configurations
require "window-picker".setup()
require "gitsigns".setup()
require "mini.pairs".setup()
require "mason".setup()
require "mini.pick".setup()
require "neo-tree".setup({
	close_if_last_window = true,
	window = {
		width = 25,
		mappings = {
			['l'] = 'open',
			['h'] = 'close_node',
		},
	},
	filesystem = {
		filtered_items = {
			visible = true,
		},
		use_libuv_file_watcher = true,
	},
})
-- require "oil".setup()
require "nvim-treesitter.configs".setup({
	ensure_installed = { "go", "javascript", "json", "lua", "python" },
	highlight = { enable = true }
})

vim.cmd("colorscheme cyberdream")
vim.cmd(":hi statusline guibg=NONE")
