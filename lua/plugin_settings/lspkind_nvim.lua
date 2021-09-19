--[[
 ╔═══════════════════════════════════╗
 ║ Settings for onsails/lspkind-nvim ║
 ╚═══════════════════════════════════╝
--]]
require("lspkind").init {
  -- override preset symbols
  --
  -- default: {}
  symbol_map = {
    Class = "ﴯ",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "ﰠ",
    File = "",
    Folder = "",
    Function = "",
    Interface = "",
    Keyword = "",
    Method = "",
    Module = "",
    Operator = "",
    Text = "",
    Property = "ﰠ",
    Reference = "",
    Snippet = "",
    Struct = "פּ",
    TypeParameter = "",
    Unit = "塞",
    Value = "",
    Variable = "",
  },
}
