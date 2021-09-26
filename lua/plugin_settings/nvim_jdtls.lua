--[[
 ╔══════════════════════════════════════╗
 ║ Settings for mfussenegger/nvim-jdtls ║
 ╚══════════════════════════════════════╝
--]]
local M = {}
local jdtls = require "jdtls"
local jdtls_setup = require "jdtls.setup"

local function ui_extension()
  local finders = require "telescope.finders"
  local sorters = require "telescope.sorters"
  local actions = require "telescope.actions"
  local pickers = require "telescope.pickers"

  require("jdtls.ui").pick_one_async = function(items, prompt, label_fn, cb)
    local opts = {}
    pickers.new(opts, {
      prompt_title = prompt,
      finder = finders.new_table {
        results = items,
        entry_maker = function(entry)
          return {
            value = entry,
            display = label_fn(entry),
            ordinal = label_fn(entry),
          }
        end
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = actions.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)

          cb(selection.value)
        end)

        return true
      end
    }):find()
  end
end

function M.setup()
  ui_extension()

  local workspace_dir = os.getenv("HOME") .. "/.config/nvim/workspace/"
  local helper_path = require("utils").get_plugin_settings_folder_name() .. "."
    .. require("utils").get_nvim_lspconfig_folder_name() .. ".helper"
  local helper = require(helper_path)

  local function on_attach(client, bufnr)
    helper.on_attach(client, bufnr)

    -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
    -- you make during a debug session immediately.
    -- Remove the option if you do not want that.
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("jdtls.setup").add_commands()
    require("jdtls.dap").setup_dap_main_class_configs()

    -- array of mappings to setup; {<capability_name>, <mode>, <lhs>, <rhs>}
    local key_mappings = {
      {"document_range_formatting", "v", "<Space>f", "<Esc><Cmd>lua vim.lsp.buf.range_formatting()<CR>"},
      {"signature_help", "i", "<c-space>",  "<Cmd>lua vim.lsp.buf.signature_help()<CR>"},
    }

    local api = vim.api
    local opts = { silent = true; noremap = true; }

    for _, mappings in pairs(key_mappings) do
      local capability, mode, lhs, rhs = unpack(mappings)
      if client.resolved_capabilities[capability] then
        api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
      end
    end

    vim.cmd('augroup lsp_aucmds')
    vim.cmd(string.format('au! * <buffer=%d>', bufnr))
    if client.resolved_capabilities['document_highlight'] then
      vim.cmd(string.format('au CursorHold  <buffer=%d> lua vim.lsp.buf.document_highlight()', bufnr))
      vim.cmd(string.format('au CursorHoldI <buffer=%d> lua vim.lsp.buf.document_highlight()', bufnr))
      vim.cmd(string.format('au CursorMoved <buffer=%d> lua vim.lsp.buf.clear_references()', bufnr))
    end
    if vim.lsp.codelens and client.resolved_capabilities['code_lens'] then
      -- vim.cmd(string.format('au BufEnter,BufModifiedSet,InsertLeave <buffer=%d> lua vim.lsp.codelens.refresh()', bufnr))
      api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<Cmd>lua vim.lsp.codelens.refresh()<CR>", opts)
      api.nvim_buf_set_keymap(bufnr, "n", "<leader>ce", "<Cmd>lua vim.lsp.codelens.run()<CR>", opts)
    end
    vim.cmd('augroup end')
  end

  jdtls.start_or_attach {
    cmd = {
      "java-lsp.sh",
      workspace_dir .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    },
    init_options = {
      bundles = {
        helper.get_java_debug_jar()
      }
    },
    settings = {
      java = {
        signatureHelp = { enabled = true },
        contentProvider = { preferred = 'fernflower' },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          }
        },
        implementationsCodeLens = {
          enabled = true
        },
        referencesCodeLens = {
          enabled = true
        }
      }
    },
    capabilities = helper.get_extended_capabilities(),
    flags = {
      debounce_text_changes = 150,
      allow_incremental_sync = true,
      server_side_fuzzy_completion = true
    },
    on_attach = on_attach,
    root_dir = jdtls_setup.find_root({
      ".git",
      "mvnw",
      "mvnw.cmd"
    })
  }

  local map = require("utils").map

  map("n", "<A-CR>", "<Cmd>lua require('jdtls').code_action()<CR>")
  map("v", "<A-CR>", "<Esc><Cmd>lua require('jdtls').code_action(true)<CR>")
  map("n", "<Leader>r", "<Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>")

  map("n", "<A-o>", "<Cmd>lua require'jdtls'.organize_imports()<CR>")
  map("n", "crv", "<Cmd>lua require('jdtls').extract_variable()<CR>")
  map("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>")
  map("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>")
  map("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>")
  map("v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>")
end

return M
