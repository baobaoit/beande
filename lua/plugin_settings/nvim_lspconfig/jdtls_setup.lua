--[[
 ╔══════════════════╗
 ║ Setup for JDT.LS ║
 ╚══════════════════╝
--]]
local java_home = os.getenv'JAVA_HOME'
local user_home = os.getenv'HOME'
local jdtls_workspace = user_home .. '/.config/nvim/workspace'
local utils = require'utils'
local plugin_settings_nvim_lspconfig_path = utils.get_plugin_settings_folder_name() .. '.' .. utils.get_nvim_lspconfig_folder_name()
local helper = require(plugin_settings_nvim_lspconfig_path .. '.helper')

return {
  cmd = {
    java_home .. '/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '-Xmx2G',
    '-jar', helper.get_jdtls_jar(),
    '-configuration', helper.get_jdtls_config(),
    '-data', jdtls_workspace,
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED'
  },
  init_options = {
    jvm_args = {
      -- '-javaagent:'..userHome..'/.m2/repository/org/projectlombok/lombok/1.18.20/lombok-1.18.20.jar',
      -- '-Xbootclasspath/a:'..userHome..'/.m2/repository/org/projectlombok/lombok/1.18.21/lombok-1.18.20.jar'
    },
    bundles = {
      helper.get_java_debug_jar()
    }
  },
  settings = {
    ['java.sources.organizeImports.starThreshold'] = 9999,
    ['java.sources.organizeImports.staticStarThreshold'] = 9999
  },
}
