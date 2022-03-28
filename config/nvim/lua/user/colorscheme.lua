local colorscheme = "tokyonight"
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "terminal", "packer" }
vim.g.tokyonight_italic_comments = true


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
--

-- local colorscheme = "material"
--
-- vim.g.material_style = 'deep ocean'
--
-- require('material').setup({
--   contrast = {
--     sidebars = true,
--     cursor_line = true,
--   },
--   italics = {
--     comments = true,
--     functions = true,
--   },
--   contrast_filetypes = {
--     "terminal",
--     "packer",
--   },
--   disable = {
--     borders = true,
--     eob_lines = true,
--   },
--   lualine_style = 'normal'
-- })
--
--
--
-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
--   vim.notify("colorscheme " .. colorscheme .."not found!")
--   return
-- end
--
