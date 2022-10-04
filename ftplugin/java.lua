-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local fn = vim.fn
local project_name = fn.fnamemodify(fn.getcwd(), ':p:h:t')

local home_dir = os.getenv('HOME')
local jabba_jdk_dir = home_dir..'/.jabba/jdk/'
local jdk8_dir = jabba_jdk_dir..'1.8.0/Contents/Home'
local nvim_dir = home_dir..'/.config/nvim'
local rule_dir = nvim_dir..'/rule/'
local java_settings_url = rule_dir..'settings.prefs'
local java_format_style_rule = rule_dir..'eclipse-java-google-style.xml'
local java_debug_jar = nvim_dir..'/java-debug/*.jar'
local workspace_root_dir = nvim_dir..'/workspace/'
local workspace_dir = workspace_root_dir..project_name
local lombok_jar = vim.fn.expand(home_dir..'/.m2/repository/org/projectlombok/lombok/*/*.jar')
local lsp = require('plugins.lsp')

local on_attach = function(client, bufnr)
  lsp.on_attach(client, bufnr)
  lsp.navic_attach_and_setup(client, bufnr)

  -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
  -- you make during a debug session immediately.
  -- Remove the option if you do not want that.
  require("jdtls").setup_dap({ hotcodereplace = "auto" })
  require("jdtls.setup").add_commands()
  require("jdtls.dap").setup_dap_main_class_configs()
end

local is_file_exist = function(path)
  local f = io.open(path, 'r')
  return f ~= nil and io.close(f)
end

local get_lombok_javaagent = function()
  if is_file_exist(lombok_jar) then
    return string.format('--jvm-arg=-javaagent:%s', lombok_jar)
  end
end

local get_lombok_bootclasspath = function()
  if is_file_exist(lombok_jar) then
    return string.format('--jvm-arg=-Xbootclasspath/a:%s', lombok_jar)
  end
end

local get_java_debug_jar = function()
  local jdj_full_path = fn.expand(java_debug_jar)
  if is_file_exist(jdj_full_path) then
    return jdj_full_path
  end
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- Watch out for the 💀, it indicates that you must adjust something.
local config = {
  cmd = {

    -- 💀
    'jdtls',

    get_lombok_javaagent(),
    get_lombok_bootclasspath(),

    -- 💀
    -- See `data directory configuration` section in the README
    '-data', workspace_dir,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    ['java.settings.url'] = java_settings_url,
    java = {
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        runtimes = {
          {
            name = 'JavaSE-1.8',
            path = jdk8_dir
          }
        }
      },
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
      contentProvider = { preferred = 'fernflower' },
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
      format = {
        settings = {
          url = java_format_style_rule,
          profile = 'GoogleStyle'
        }
      }
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {
      get_java_debug_jar()
    }
  },

  capabilities = lsp.get_capabilities(),
  flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
    server_side_fuzzy_completion = true
  },
  ['on_attach'] = on_attach,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
-- require('wlsample.airline')

local wk = require('which-key')
wk.register({
  ['<A-CR>'] = {
      '<Esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>',
      'Range code action'
  },
  c = {
    rv = {
      '<Esc><Cmd>lua require("jdtls").extract_variable(true)<CR>',
      'Extract variable'
    },
    rc = {
      '<Esc><Cmd>lua require("jdtls").extract_constant(true)<CR>',
      'Extract constant'
    },
    rm = {
      '<Esc><Cmd>lua require("jdtls").extract_method(true)<CR>',
      'Extract method'
    }
  }
}, {
  mode = 'v'
})

wk.register({
  ['<A-o>'] = {
    '<Cmd>lua require("jdtls").organize_imports()<CR>',
    'Organize imports'
  },
  c = {
    rv = {
      '<Cmd>lua require("jdtls").extract_variable()<CR>',
      'Extract variable'
    },
    rc = {
      '<Cmd>lua require("jdtls").extract_constant()<CR>',
      'Extract constant'
    }
  }
})
