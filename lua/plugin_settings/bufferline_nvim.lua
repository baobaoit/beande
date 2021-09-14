--[[
 ╔══════════════════════════════════════╗
 ║ Settings for akinsho/bufferline.nvim ║
 ╚══════════════════════════════════════╝
--]]
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
    separator_style = 'thick', -- 'slant' | 'thick' | 'thin' | { 'any', 'any' },
    enforce_regular_tabs = false, -- false | true,
    always_show_bufferline = true, -- true | false,
    sort_by = 'extension', -- 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
      -- add custom logic
      -- return buffer_a.modified > buffer_b.modified
    -- end
  }
}

local map = require'utils'.map

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
map('n', 'b]', ':BufferLineCycleNext<CR>')
map('n', '[b', ':BufferLineCyclePrev<CR>')

-- These commands will move the current buffer backwards or forwards in the bufferline
map('n', '<Leader>b]', ':BufferLineMoveNext<CR>')
map('n', '<Leader>[b', ':BufferLineMovePrev<CR>')

-- These commands will sort buffers by directory, languages
map('n', '<Leader>be', ':BufferLineSortByExtension<CR>')
map('n', '<Leader>bd', ':BufferLineSortDirectory<CR>')
