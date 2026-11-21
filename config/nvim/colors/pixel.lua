-- pixel: matches the Herdr app's pixel theme (dotfiles: config/herdr-app/themes/pixel.json).
-- Deep navy, cream text, teal borders, warm CRT orange accent.

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "pixel"

local C = {
	bg = "#05182e",
	surface = "#081e33",
	popover = "#0a2338",
	raised = "#0d2b44",
	hover = "#11324d",
	selected = "#134e5a",
	border = "#2a6b78",
	fg = "#f6dcac",
	muted = "#b5c2b2",
	dim = "#5a7d8c",
	accent = "#faa968",
	orange = "#e97b3c",
	red = "#f85525",
	green = "#028391",
	teal = "#3f8f8a",
	seafoam = "#8cbfb8",
	done = "#7ec8a9",
}

local function hl(group, spec)
	vim.api.nvim_set_hl(0, group, spec)
end

-- Terminal ANSI, same as the Herdr pixel theme.
local ansi = {
	C.bg, C.red, C.green, C.orange, C.teal, C.teal, C.seafoam, C.fg,
	C.border, C.red, C.green, C.orange, C.accent, C.teal, C.seafoam, C.fg,
}
for i, color in ipairs(ansi) do
	vim.g["terminal_color_" .. (i - 1)] = color
end

-- Base
hl("Normal", { fg = C.fg, bg = C.bg })
hl("NormalNC", { fg = C.fg, bg = C.bg })
hl("NormalFloat", { fg = C.fg, bg = C.popover })
hl("FloatBorder", { fg = C.border, bg = C.popover })
hl("FloatTitle", { fg = C.accent, bg = C.popover, bold = true })
hl("FloatFooter", { fg = C.dim, bg = C.popover })
hl("Cursor", { fg = C.bg, bg = C.accent })
hl("CursorLine", { bg = C.surface })
hl("CursorColumn", { bg = C.surface })
hl("LineNr", { fg = C.dim })
hl("CursorLineNr", { fg = C.accent, bold = true })
hl("SignColumn", { bg = C.bg })
hl("VertSplit", { fg = C.border })
hl("WinSeparator", { fg = C.border })
hl("StatusLine", { fg = C.muted, bg = "NONE" })
hl("StatusLineNC", { fg = C.dim, bg = "NONE" })
hl("TabLine", { fg = C.dim, bg = C.surface })
hl("TabLineSel", { fg = C.fg, bg = C.raised, bold = true })
hl("TabLineFill", { fg = C.dim, bg = "NONE" })
hl("WinBar", { fg = C.muted, bg = C.bg, bold = true })
hl("WinBarNC", { fg = C.dim, bg = C.bg })
hl("MsgArea", { fg = C.fg })
hl("ModeMsg", { fg = C.dim })
hl("MoreMsg", { fg = C.green })
hl("Question", { fg = C.green })
hl("WarningMsg", { fg = C.orange })
hl("ErrorMsg", { fg = C.red })
hl("Directory", { fg = C.accent, bold = true })
hl("Title", { fg = C.accent, bold = true })
hl("Conceal", { fg = C.dim })
hl("NonText", { fg = C.border })
hl("Whitespace", { fg = C.border })
hl("SpecialKey", { fg = C.border })
hl("EndOfBuffer", { fg = C.bg })
hl("QuickFixLine", { bg = C.hover })
hl("qfFileName", { fg = C.accent })
hl("qfLineNr", { fg = C.dim })
hl("MatchParen", { fg = C.accent, bg = C.selected, bold = true })
hl("Visual", { bg = C.selected })
hl("VisualNOS", { bg = C.hover })
hl("Search", { bg = C.selected })
hl("IncSearch", { fg = C.bg, bg = C.accent })
hl("CurSearch", { fg = C.bg, bg = C.accent, bold = true })
hl("Substitute", { fg = C.bg, bg = C.orange })
hl("Pmenu", { fg = C.fg, bg = C.popover })
hl("PmenuSel", { fg = C.fg, bg = C.selected })
hl("PmenuSbar", { bg = C.raised })
hl("PmenuKind", { fg = C.dim })
hl("WildMenu", { fg = C.bg, bg = C.accent })
hl("Folded", { fg = C.dim, bg = C.surface })
hl("FoldColumn", { fg = C.dim })
hl("ColorColumn", { bg = C.surface })
hl("SnippetTabstop", { bg = C.hover })

-- Diff
hl("DiffAdd", { bg = "#043347" })
hl("DiffChange", { bg = "#423c3c" })
hl("DiffDelete", { bg = "#42272c" })
hl("DiffText", { bg = "#553b33" })
hl("Added", { fg = C.green })
hl("Changed", { fg = C.accent })
hl("Removed", { fg = C.red })

-- Classic syntax groups (fallbacks treesitter links to)
hl("Comment", { fg = C.dim, italic = true })
hl("Constant", { fg = C.red })
hl("String", { fg = C.seafoam })
hl("Character", { fg = C.seafoam })
hl("Number", { fg = C.red })
hl("Boolean", { fg = C.red })
hl("Float", { fg = C.red })
hl("Identifier", { fg = C.fg })
hl("Function", { fg = C.orange })
hl("Statement", { fg = C.accent })
hl("Conditional", { fg = C.accent })
hl("Repeat", { fg = C.accent })
hl("Label", { fg = C.accent })
hl("Operator", { fg = C.accent })
hl("Keyword", { fg = C.accent })
hl("Exception", { fg = C.red })
hl("PreProc", { fg = C.seafoam })
hl("Include", { fg = C.accent })
hl("Define", { fg = C.accent })
hl("Macro", { fg = C.seafoam })
hl("PreCondit", { fg = C.accent })
hl("Type", { fg = C.done })
hl("StorageClass", { fg = C.accent })
hl("Structure", { fg = C.done })
hl("Typedef", { fg = C.done })
hl("Special", { fg = C.accent })
hl("SpecialChar", { fg = C.orange })
hl("Tag", { fg = C.orange })
hl("Delimiter", { fg = C.muted })
hl("SpecialComment", { fg = C.dim })
hl("Debug", { fg = C.orange })
hl("Underlined", { fg = C.accent, underline = true })
hl("Ignore", { fg = C.dim })
hl("Error", { fg = C.red })
hl("Todo", { fg = C.accent, bold = true })

-- Treesitter
hl("@variable", { fg = C.fg })
hl("@variable.builtin", { fg = C.orange, italic = true })
hl("@variable.parameter", { fg = C.seafoam, italic = true })
hl("@property", { fg = C.muted })
hl("@constant.builtin", { fg = C.red })
hl("@module", { fg = C.done })
hl("@label", { fg = C.seafoam })
hl("@string", { fg = C.seafoam })
hl("@string.escape", { fg = C.orange })
hl("@string.special", { fg = C.orange })
hl("@character", { fg = C.seafoam })
hl("@number", { fg = C.red })
hl("@boolean", { fg = C.red })
hl("@function", { fg = C.orange })
hl("@function.call", { fg = C.orange })
hl("@function.builtin", { fg = C.orange, italic = true })
hl("@constructor", { fg = C.muted })
hl("@keyword", { fg = C.accent })
hl("@keyword.function", { fg = C.accent })
hl("@keyword.operator", { fg = C.accent })
hl("@keyword.return", { fg = C.accent })
hl("@conditional", { fg = C.accent })
hl("@repeat", { fg = C.accent })
hl("@exception", { fg = C.red })
hl("@include", { fg = C.accent })
hl("@type", { fg = C.done })
hl("@type.builtin", { fg = C.done })
hl("@type.qualifier", { fg = C.accent })
hl("@definition", { fg = C.orange })
hl("@attribute", { fg = C.accent })
hl("@property.json", { fg = C.accent })
hl("@field", { fg = C.muted })
hl("@punctuation.delimiter", { fg = C.muted })
hl("@punctuation.bracket", { fg = C.muted })
hl("@punctuation.special", { fg = C.accent })
hl("@comment", { fg = C.dim, italic = true })
hl("@operator", { fg = C.accent })
hl("@tag", { fg = C.orange })
hl("@tag.attribute", { fg = C.accent })
hl("@markup.heading", { fg = C.accent, bold = true })
hl("@markup.italic", { italic = true })
hl("@markup.bold", { bold = true })
hl("@markup.link", { fg = C.accent, underline = true })
hl("@markup.raw", { fg = C.seafoam })
hl("@diff.plus", { fg = C.green })
hl("@diff.minus", { fg = C.red })
hl("@diff.delta", { fg = C.accent })

-- Diagnostics / LSP
hl("DiagnosticError", { fg = C.red })
hl("DiagnosticWarn", { fg = C.orange })
hl("DiagnosticInfo", { fg = C.green })
hl("DiagnosticHint", { fg = C.teal })
hl("DiagnosticUnderlineError", { undercurl = true, sp = C.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = C.orange })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = C.green })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = C.teal })
hl("LspReferenceText", { bg = C.hover })
hl("LspReferenceRead", { bg = C.hover })
hl("LspReferenceWrite", { bg = C.hover })
hl("LspInlayHint", { fg = C.dim, bg = "NONE", italic = true })
hl("LspCodeLens", { fg = C.dim })

-- Git
hl("SignAdd", { fg = C.green })
hl("SignChange", { fg = C.accent })
hl("SignDelete", { fg = C.red })
hl("GitSignsAdd", { fg = C.green })
hl("GitSignsChange", { fg = C.accent })
hl("GitSignsDelete", { fg = C.red })
hl("GitSignsAddLn", { fg = C.bg, bg = C.green })
hl("GitSignsChangeLn", { fg = C.bg, bg = C.accent })
hl("GitSignsDeleteLn", { fg = C.bg, bg = C.red })
hl("GitSignsAddCul", { fg = C.green, bold = true })
hl("GitSignsChangeCul", { fg = C.accent, bold = true })
hl("GitSignsDeleteCul", { fg = C.red, bold = true })
hl("GitSignsCurrentLineBlame", { fg = C.dim, italic = true })

-- indent-blankline
hl("IblIndent", { fg = "#1f4a56" })
hl("IblScope", { fg = C.border })
hl("@ibl.scope.underline.1", { underline = true, sp = C.border })

-- Plugins
hl("WhichKey", { fg = C.accent })
hl("WhichKeyDesc", { fg = C.fg })
hl("WhichKeyGroup", { fg = C.orange })
hl("WhichKeySeparator", { fg = C.dim })
hl("WhichKeyFloat", { bg = C.popover })
hl("WhichKeyBorder", { fg = C.border })

-- todo-comments
hl("TodoFgTODO", { fg = C.accent, bold = true })
hl("TodoFgFIX", { fg = C.red, bold = true })
hl("TodoFgFIXME", { fg = C.red, bold = true })
hl("TodoFgHACK", { fg = C.orange, bold = true })
hl("TodoFgNOTE", { fg = C.green, bold = true })
hl("TodoFgPERF", { fg = C.seafoam, bold = true })

-- neo-tree
hl("NeoTreeNormal", { fg = C.muted, bg = C.surface })
hl("NeoTreeNormalNC", { fg = C.muted, bg = C.surface })
hl("NeoTreeDirectoryName", { fg = C.muted })
hl("NeoTreeDirectoryIcon", { fg = C.accent })
hl("NeoTreeFileNameOpened", { fg = C.fg })
hl("NeoTreeIndentMarker", { fg = C.border })
hl("NeoTreeGitAdded", { fg = C.green })
hl("NeoTreeGitModified", { fg = C.accent })
hl("NeoTreeGitDeleted", { fg = C.red })
hl("NeoTreeRootName", { fg = C.accent, bold = true })
hl("NeoTreeSymbolicLinkTarget", { fg = C.teal })

-- notify / fidget
hl("NotifyINFOBorder", { fg = C.border })
hl("NotifyWARNBorder", { fg = C.border })
hl("NotifyERRORBorder", { fg = C.border })
hl("NotifyINFOTitle", { fg = C.green })
hl("NotifyWARNTitle", { fg = C.orange })
hl("NotifyERRORTitle", { fg = C.red })
hl("NotifyINFOIcon", { fg = C.green })
hl("NotifyWARNIcon", { fg = C.orange })
hl("NotifyERRORIcon", { fg = C.red })
hl("FidgetTask", { fg = C.dim })
hl("FidgetTitle", { fg = C.accent })
