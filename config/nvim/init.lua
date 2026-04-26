-- options
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.swapfile = false
vim.g.mapleader = " "
vim.g.have_nerd_font = true
vim.o.winborder = "rounded"
vim.o.undofile = true
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorcolumn = false
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.hlsearch = false
vim.o.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.o.scrolloff = 8
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.mouse = "a"
vim.o.hidden = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.confirm = true
vim.o.pumheight = 10
vim.o.smoothscroll = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", extends = "›", precedes = "‹" }
vim.opt.fillchars = { diff = "╱", eob = " " }
vim.opt.shortmess:append("cC")
vim.opt.diffopt:append("linematch:60")

-- keymaps (generic)
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>y", ":+y<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>d", ":+d<CR>")
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<leader>h", ":lua FzfLua.helptags()<CR>")
vim.keymap.set("n", "<leader>sf", ':lua FzfLua.files({ cwd = vim.fn.expand("%:h") })<CR>')
vim.keymap.set("n", "<leader><leader>", ":lua FzfLua.buffers()<CR>")
vim.keymap.set("n", "<leader>sg", ":lua FzfLua.live_grep()<CR>")
vim.keymap.set("n", "<leader>/", ":lua FzfLua.lgrep_curbuf()<CR>")
vim.keymap.set("n", "<leader>ft", ":Neotree toggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bd", function()
	require("mini.bufremove").delete()
end, { silent = true, desc = "Delete buffer" })
vim.keymap.set({ "n", "v" }, "<leader>lf", function()
	require("conform").format({ lsp_format = "fallback" })
end, { desc = "Format with conform" })

-- Better editing keymaps
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")

-- LSP keymaps (buffer-local via LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }
		vim.keymap.set("n", "gd", ":lua FzfLua.lsp_definitions()<CR>", opts)
		vim.keymap.set("n", "gr", ":lua FzfLua.lsp_references()<CR>", opts)
		vim.keymap.set("n", "gI", ":lua FzfLua.lsp_implementations()<CR>", opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>ds", ":lua FzfLua.lsp_document_symbols()<CR>", opts)
		vim.keymap.set("n", "<leader>ws", ":lua FzfLua.lsp_workspace_symbols()<CR>", opts)

		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client.server_capabilities.inlayHintProvider then
			vim.keymap.set("n", "<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
			end, { buffer = ev.buf, desc = "Toggle inlay hints" })
		end
	end,
})

-- diagnostics UI
vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
})

-- plugins
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/scottmckendry/cyberdream.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/nvim-mini/mini.cursorword" },
	{ src = "https://github.com/echasnovski/mini.comment" },
	{ src = "https://github.com/echasnovski/mini.surround" },
	{ src = "https://github.com/echasnovski/mini.bufremove" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("3") },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },
})

-- plugins setup and configurations
require("gitsigns").setup({ current_line_blame = true })
require("mini.pairs").setup()
require("mini.comment").setup()
require("mini.surround").setup()
require("mini.bufremove").setup()
require("mini.cursorword").setup()
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "gopls", "vtsls", "jsonls", "html", "cssls", "bashls", "pyright", "yamlls" },
	automatic_installation = true,
})
require("fzf-lua").setup()
require("todo-comments").setup()
require("fidget").setup({ notification = { override_vim_notify = true } })
require("nvim-ts-autotag").setup()

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"go",
		"javascript",
		"json",
		"lua",
		"python",
		"typescript",
		"bash",
		"html",
		"css",
		"yaml",
		"markdown",
	},
	highlight = { enable = true },
	indent = { enable = true },
	auto_install = true,
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
			scope_incremental = false,
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
			},
		},
	},
})

-- neo-tree
require("neo-tree").setup({
	close_if_last_window = true,
	window = {
		width = 25,
		mappings = {
			["l"] = "open",
			["h"] = "close_node",
		},
	},
	filesystem = {
		filtered_items = {
			visible = true,
		},
		use_libuv_file_watcher = true,
	},
})

-- blink.cmp
require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = { nerd_font_variant = "mono" },
	snippets = { preset = "default" },
	fuzzy = {
		sorts = { "exact", "score", "sort_text", "label" },
	},
	cmdline = { enabled = true },
	signature = { enabled = true },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	completion = {
		keyword = { range = "full" },
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		ghost_text = { enabled = true },
	},
})

-- conform.nvim (formatting)
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		python = { "black" },
		sh = { "shfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- lualine
require("lualine").setup({
	options = {
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	extensions = { "neo-tree", "trouble" },
})

-- nvim-notify
require("notify").setup({
	stages = "fade",
	timeout = 3000,
	background_colour = "#000000",
})
vim.notify = require("notify")

-- indent-blankline
require("ibl").setup()

-- which-key
require("which-key").setup()
local wk = require("which-key")
wk.add({
	{ "<leader>s", group = "search" },
	{ "<leader>x", group = "diagnostics / todo" },
	{ "<leader>l", group = "lsp" },
	{ "<leader>t", group = "toggle" },
})

-- trouble
require("trouble").setup()
vim.keymap.set("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", { silent = true, desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xt", ":TodoTrouble<CR>", { silent = true, desc = "Todos (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xT",
	":TodoTrouble keywords=TODO,FIX,FIXME,HACK<CR>",
	{ silent = true, desc = "All todos (Trouble)" }
)

-- LSP configs
vim.lsp.config("gopls", {
	settings = {
		["gopls"] = {
			gofumpt = true,
		},
	},
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})
vim.lsp.enable({ "lua_ls", "gopls", "vtsls", "jsonls", "html", "cssls", "bashls", "pyright", "yamlls" })

vim.cmd("colorscheme cyberdream")
vim.cmd("hi statusline guibg=NONE")

-- Autocmds
-- golang organize imports + lsp format on save
local function go_organize_imports()
	local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
	params.context = { only = { "source.organizeImports" }, diagnostics = {} }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
	if not result then
		return
	end
	for _, res in pairs(result) do
		if res.result then
			for _, action in pairs(res.result) do
				if action.edit then
					vim.lsp.util.apply_workspace_edit(action.edit, vim.lsp.util._get_offset_encoding())
				elseif action.command then
					vim.lsp.buf.execute_command(action)
				end
			end
		end
	end
end

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function(args)
		go_organize_imports()
		vim.lsp.buf.format({ bufnr = args.buf, async = false, timeout_ms = 3000 })
	end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Restore cursor position when reopening files
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local exclude = { "gitcommit" }
		if vim.tbl_contains(exclude, vim.bo[args.buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local lcount = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Equalize splits when terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("ResizeSplits", { clear = true }),
	command = "wincmd =",
})

-- Disable auto-comment on 'o'/'O' in normal mode
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("FormatOptions", { clear = true }),
	callback = function()
		vim.opt_local.formatoptions:remove("or")
	end,
})

-- Filetype-specific settings for prose
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
		vim.opt_local.breakindent = true
		vim.opt_local.linebreak = true
		vim.opt_local.showbreak = "↪ "
	end,
})
