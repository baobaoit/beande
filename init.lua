--------- Helpers ---------
local cmd = vim.cmd -- vim commands
local fn = vim.fn -- vim functions
local g = vim.g -- global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local api = vim.api

local function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup '..group_name)
    api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      -- if type(def) == 'table' and type(def[#def]) == 'function' then
      --   def[#def] = lua_callback(def[#def])
      -- end
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      api.nvim_command(command)
    end
    api.nvim_command('augroup END')
  end
end

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts) -- noremap
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

--------- Plugins ---------
require 'paq' {
-- Package manager
  'savq/paq-nvim'; -- Let Paq manage itself
-- Status bar
  'hoob3rt/lualine.nvim';
-- Theme
  'monsonjeremy/onedark.nvim';
-- File explorer
  'kyazdani42/nvim-tree.lua';
  'kyazdani42/nvim-web-devicons';
-- Java JDT.LS
  'neovim/nvim-lspconfig';
  'mfussenegger/nvim-jdtls';
-- Syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  };
-- Terminal
  'akinsho/toggleterm.nvim';
-- Completion
  'hrsh7th/nvim-cmp';
  'hrsh7th/vim-vsnip';
  'hrsh7th/cmp-buffer';
  'onsails/lspkind-nvim';
  'hrsh7th/cmp-nvim-lsp';
  'L3MON4D3/LuaSnip';
-- Auto pairs
  'windwp/nvim-autopairs';
-- Code analyze
  'dense-analysis/ale';
-- Buffer line
  'akinsho/bufferline.nvim';
-- Debug
  'mfussenegger/nvim-dap';
-- Telescope
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
}

--------- hoob3rt/lualine.nvim ---------
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch','diff'},
    lualine_c = {
      {
        'filename',
        -- 0 = just filename, 1 = relative path, 2 = absolute path
        path = 1
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {
    -- Lualine extensions change statusline appearance for a window/buffer with specified filetypes.
    -- By default no extension are loaded to improve performance.
    -- Available extensions: 'chadtree','fugitive','fzf','nerdtree','nvim-tree','quickfix'
  }
}
--------- hoob3rt/lualine.nvim ---------

--------- monsonjeremy/onedark.nvim ---------
require'onedark'.setup {
  transparent = true,
  sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' },
-- Change the 'hint' color to the 'orange' color, and make the 'error' color bright red
  colors = { hint = 'orange', error = '#ff0000' }
}

-- Load the colorscheme
cmd[[colorscheme onedark]]
--------- monsonjeremy/onedark.nvim ---------

local mapOptSilent = { silent = true }

--------- kyazdani42/nvim-tree.lua ---------
-- 0 by default, opens the tree when typing `vim $DIR` or `vim`
g.nvim_tree_auto_open = 1

-- 0 by default, closes the tree when you open a file
g.nvim_tree_quit_on_open = 1

-- 0 by default, this option allows the cursor to be updated when entering a buffer
g.nvim_tree_follow = 1

-- 0 by default, will update the path of the current dir if the file is not inside the tree.
g.nvim_tree_follow_update_path = 1

-- 0 by default, this option shows indent markers when folders are open
g.nvim_tree_indent_markers = 1

-- 0 by default, this option hides files and folders starting with a dot `.`
g.nvim_tree_hide_dotfiles = 1

-- 0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_group_empty = 1

map('n', '<C-b>', ':NvimTreeToggle<CR>', mapOptSilent)
map('n', '<Leader>r', ':NvimTreeRefresh<CR>', mapOptSilent)
map('n', '<Leader>n', ':NvimTreeFindFile<CR>', mapOptSilent)

-- a list of groups can be found at `:help nvim_tree_highlight`
-- cmd[[au VimEnter * highlight NvimTreeFolderIcon guibg=blue]]
--------- kyazdani42/nvim-tree.lua ---------

--------- kyazdani42/nvim-web-devicons ---------
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 -- override = {
 --  zsh = {
 --    icon = '',
 --    color = '#428850',
 --    name = 'Zsh'
 --  }
 -- };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

require'nvim-web-devicons'.has_loaded()

require'nvim-web-devicons'.get_icons()
--------- kyazdani42/nvim-web-devicons ---------

--------- nvim-treesitter/nvim-treesitter ---------
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained', -- one of 'all', 'maintained' (parsers with maintainers), or a list of languages
  highlight = {
    enable = true
  },
  indent = {
    enable = false
  }
}
--------- nvim-treesitter/nvim-treesitter ---------

--------- akinsho/toggleterm.nvim ---------
require'toggleterm'.setup {
  -- size can be a number or function which is passed the current terminal
  -- size = 20 | function(term)
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<C-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_terminals = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'float', -- 'vertical' | 'horizontal' | 'window' | 'float',
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    -- width = <value>,
    -- height = <value>,
    highlights = {
      border = 'Normal',
      background = 'Normal',
    }
  }
}
--------- akinsho/toggleterm.nvim ---------

--------- onsails/lspkind-nvim ---------
local lspkind = require'lspkind'
lspkind.init {
  -- override preset symbols
  --
  -- default: {}
  symbol_map = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = 'ﰠ',
    Variable = '',
    Class = 'ﴯ',
    Interface = '',
    Module = '',
    Property = 'ﰠ',
    Unit = '塞',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = 'פּ',
    Event = '',
    Operator = '',
    TypeParameter = ''
  },
}
--------- onsails/lspkind-nvim ---------

--------- hrsh7th/nvim-cmp ---------
local cmp = require'cmp'
local luasnip = require'luasnip'
cmp.setup {
  snippet = {
    expand = function(args)
      fn['vsnip#anonymous'](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = function(fallback)
      if fn.pumvisible() == 1 then
        fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if fn.pumvisible() == 1 then
        fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' .. vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
        latex_symbols = '[Latex]',
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp' },
  },
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
--------- hrsh7th/nvim-cmp ---------

--------- neovim/nvim-lspconfig ---------
local javaHome = os.getenv'JAVA_HOME'
local jdtlsHome = os.getenv'JDTLS_HOME'
local userHome = os.getenv'HOME'
local jdtlsWorkspace = userHome..'/.config/nvim/workspace'
local sysname = vim.loop.os_uname().sysname

local function get_jdtls_config()
  local folderConfig = 'config_linux'
  if sysname:match 'Darwin' then
    folderConfig = 'config_mac'
  elseif sysname:match 'Windows' then
    folderConfig = 'config_win'
  end
  return jdtlsHome..'/'..folderConfig
end

local function get_jdtls_jar()
  return fn.expand(jdtlsHome..'/plugins/org.eclipse.equinox.launcher_*.jar')
end

local function get_java_debug_jar()
  return fn.expand(userHome..'/.config/nvim/java-debug/com.microsoft.java.debug.plugin-*.jar')
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

require'lspconfig'.jdtls.setup {
  cmd = {
    javaHome..'/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '-Xmx2G',
    '-jar', get_jdtls_jar(),
    '-configuration', get_jdtls_config(),
    '-data', jdtlsWorkspace,
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED'
  },
  init_options = {
    jvm_args = {
      -- '-javaagent:'..userHome..'/.m2/repository/org/projectlombok/lombok/1.18.20/lombok-1.18.20.jar -Xbootclasspath/a:'..userHome..'/.m2/repository/org/projectlombok/lombok/1.18.21/lombok-1.18.20.jar'
    },
    workspace = jdtlsWorkspace,
    bundles = {
      get_java_debug_jar()
    }
  },
  settings = {
    ['java.sources.organizeImports.starThreshold'] = 9999,
    ['java.sources.organizeImports.staticStarThreshold'] = 9999
  },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities
}


local function get_lua_language_server_env()
  local system_name = 'Linux'
  if fn.has('mac') == 1 then
    system_name = 'macOS'
  elseif fn.has('win32') == 1 then
    system_name = 'Windows'
  end
  return system_name
end

-- set the path to the sumneko installation;
local sumneko_root_path = userHome..'/.config/nvim/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/'..get_lua_language_server_env()..'/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          vim.api.nvim_get_runtime_file("", true),
          '${3rd}/love2d/library'
        },
        maxPreload = 2000,
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    }
  },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities
}

require'lspconfig'.vimls.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities
}
--------- neovim/nvim-lspconfig ---------

--------- windwp/nvim-autopairs ---------
require'nvim-autopairs'.setup {
}

-- you need setup cmp first put this after cmp.setup()
require'nvim-autopairs.completion.cmp'.setup {
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true -- automatically select the first item
}
--------- windwp/nvim-autopairs ---------

--------- dense-analysis/ale ---------
g.ale_completion_enabled = 0
g.ale_lint_on_text_changed = 'never'
--------- dense-analysis/ale ---------

--------- akinsho/bufferline.nvim ---------
require'bufferline'.setup {
  options = {
    numbers = 'both', -- 'none' | 'ordinal' | 'buffer_id' | 'both' | function({ ordinal, id, lower, raise }): string,
    --- @deprecated, please specify numbers as a function to customize the styling
    -- number_style = 'superscript' | 'subscript' | '' | { 'none', 'subscript' }, -- buffer_id at index 1, ordinal at index 2
    close_command = 'bdelete! %d',       -- can be a string | function, see 'Mouse actions'
    right_mouse_command = 'bdelete! %d', -- can be a string | function, see 'Mouse actions'
    left_mouse_command = 'buffer %d',    -- can be a string | function, see 'Mouse actions'
    middle_mouse_command = nil,          -- can be a string | function, see 'Mouse actions'
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    -- name_formatter = function(buf)  -- buf contains a 'name', 'path' and 'bufnr'
      -- remove extension from markdown files for example
      -- if buf.name:match('%.md') then
      --   return vim.fn.fnamemodify(buf.name, ':t:r')
      -- end
    -- end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = false, -- false | 'nvim_lsp' | 'coc',
    diagnostics_update_in_insert = false,
    -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
    --   return '('..count..')'
    -- end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    -- custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      -- if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
      --   return true
      -- end
      -- filter out by buffer name
      -- if vim.fn.bufname(buf_number) ~= '<buffer-name-I-dont-want>' then
      --   return true
      -- end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      -- if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
      --   return true
      -- end
    -- end,
    offsets = {{filetype = 'NvimTree', text = 'File Explorer', text_align = 'left'}}, -- {{filetype = 'NvimTree', text = 'File Explorer' | function , text_align = 'left' | 'center' | 'right'}},
    show_buffer_icons = true, -- true | false, -- disable filetype icons for buffers
    show_buffer_close_icons = true, -- true | false,
    show_close_icon = true, -- true | false,
    show_tab_indicators = true, -- true | false,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = 'thin', -- 'slant' | 'thick' | 'thin' | { 'any', 'any' },
    enforce_regular_tabs = false, -- false | true,
    always_show_bufferline = true, -- true | false,
    sort_by = 'extension', -- 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
      -- add custom logic
      -- return buffer_a.modified > buffer_b.modified
    -- end
  }
}
-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
map('n', 'b]', ':BufferLineCycleNext<CR>', mapOptSilent)
map('n', '[b', ':BufferLineCyclePrev<CR>', mapOptSilent)

-- These commands will move the current buffer backwards or forwards in the bufferline
map('n', '<Leader>b]', ':BufferLineMoveNext<CR>', mapOptSilent)
map('n', '<Leader>[b', ':BufferLineMovePrev<CR>', mapOptSilent)

-- These commands will sort buffers by directory, languages
map('n', '<Leader>be', ':BufferLineSortByExtension<CR>', mapOptSilent)
map('n', '<Leader>bd', ':BufferLineSortDirectory<CR>', mapOptSilent)
--------- akinsho/bufferline.nvim ---------

--------- mfussenegger/nvim-dap ---------
local dap = require'dap'
dap.adapters.java = function(callback, _)
  require'jdtls.util'.execute_command({command = 'vscode.java.startDebugSession'}, function(err0, port)
    assert(not err0, vim.inspect(err0))

    callback({
      type = 'server';
      host = '127.0.0.1';
      port = port;
    })
  end)
end

dap.configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = 'Debug (Attach) - Remote';
    hostName = '127.0.0.1';
    port = 5005;
  },
}

map('n', '<F5>', ':lua require\'dap\'.continue()<CR>', mapOptSilent)
map('n', '<F10>', ':lua require\'dap\'.step_over()<CR>', mapOptSilent)
map('n', '<F11>', ':lua require\'dap\'.step_into()<CR>', mapOptSilent)
map('n', '<F12>', ':lua require\'dap\'.step_out()<CR>', mapOptSilent)
map('n', '<Leader>b', ':lua require\'dap\'.toggle_breakpoint()<CR>', mapOptSilent)
map('n', '<Leader>B', ':lua require\'dap\'.set_breakpoint(vim.fn.input(\'Breakpoint condition: \'))<CR>', mapOptSilent)
map('n', '<Leader>lp', ':lua require\'dap\'.set_breakpoint(nil, nil, vim.fn.input(\'Log point message: \'))<CR>', mapOptSilent)
map('n', '<Leader>dr', ':lua require\'dap\'.repl.toggle()<CR>', mapOptSilent)
map('n', '<Leader>dl', ':lua require\'dap\'.run_last()<CR>', mapOptSilent)
--------- mfussenegger/nvim-dap ---------

--------- nvim-telescope/telescope.nvim ---------
map('n', '<Leader>ff', ':lua require(\'telescope.builtin\').find_files()<CR>', mapOptSilent)
map('n', '<Leader>fg', ':lua require(\'telescope.builtin\').live_grep()<CR>', mapOptSilent)
map('n', '<Leader>fb', ':lua require(\'telescope.builtin\').buffers()<CR>', mapOptSilent)
map('n', '<Leader>fh', ':lua require(\'telescope.builtin\').help_tags()<CR>', mapOptSilent)
--------- nvim-telescope/telescope.nvim ---------

--------- Options ---------
local indent = 2
cmd 'set t_Co=256'
cmd 'syntax on'
cmd 'filetype indent plugin on'
cmd 'set path+=**'
opt('b', 'expandtab', true) -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent) -- Size of an indent
opt('b', 'smartindent', true) -- Insert indents automatically
opt('b', 'tabstop', indent) -- Number of spaces tabs count for
opt('o', 'mouse', 'a') -- Enable mouse
opt('o', 'termguicolors', true) -- True color support
opt('o', 'wildmode', 'list:longest') -- Command-line completion mode
opt('w', 'number', true) -- Print line number
map('t', '<Esc>', '<C-\\><C-n>', mapOptSilent) -- Escape the Terminal mode
nvim_create_augroups {
  DisabledCommentInNewLine = {
    'FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
  }
}
