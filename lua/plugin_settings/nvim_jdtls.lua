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
  local action_state = require "telescope.actions.state"

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
        end,
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry(prompt_bufnr)

          actions.close(prompt_bufnr)

          cb(selection.value)
        end)

        return true
      end,
    }):find()
  end
end

function M.setup()
  ui_extension()

  local home = os.getenv("HOME")
  local java_settings_url = home .. "/.config/nvim/rule/settings.prefs"
  local workspace_dir = home .. "/.config/nvim/workspace/"
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
  end

  local lombok_ver = "1.18.20"

  jdtls.start_or_attach {
    cmd = {
      "java-lsp.sh",
      workspace_dir .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
      lombok_ver
    },
    init_options = {
      bundles = {
        helper.get_java_debug_jar()
      }
    },
    settings = {
      ["java.settings.url"] = java_settings_url,
      java = {
        codeGeneration = {
          hashCodeEquals = {
            useInstanceof = true,
            useJava7Objects = true
          },
          toString = {
            codeStyle = "STRING_BUILDER_CHAINED"
          },
          useBlocks = true,
        },
        contentProvider = { preferred = "fernflower" },
        implementationsCodeLens = {
          enabled = true
        },
        referencesCodeLens = {
          enabled = true
        },
        signatureHelp = { enabled = true },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          }
        },
      }
    },
    capabilities = helper.get_extended_capabilities(),
    flags = {
      allow_incremental_sync = true,
      debounce_text_changes = 150,
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

  map("v", "<A-CR>", "<Esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>")

  map("n", "<A-o>", "<Cmd>lua require'jdtls'.organize_imports()<CR>")
  map("n", "crv", "<Cmd>lua require('jdtls').extract_variable()<CR>")
  map("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>")
  map("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>")
  map("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>")
  map("v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>")
end

return M
