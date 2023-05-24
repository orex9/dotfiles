local options = {

  hlsearch = true,
  number = true,
  mouse = 'a',
  breakindent = true,
  undofile = true,
  ignorecase = true,
  smartcase = true,
  updatetime = 250,
  signcolumn = 'yes',
  termguicolors = true,
  completeopt = 'menuone,noselect',
  clipboard = 'unnamedplus',
  cmdheight = 2,
  conceallevel = 0,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  numberwidth = 4,
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  relativenumber = true,

}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append "c"
vim.opt.iskeyword:append "-"
vim.opt.formatoptions:remove({ "c", "r", "o" })
