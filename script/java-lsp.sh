#!/usr/bin/env bash

# NOTE:
# This doesn't work as is on Windows. You'll need to create an equivalent `.bat` file instead
#
# NOTE:
# If you're not using Linux you'll need to adjust the `-configuration` option
# to point to the `config_mac' or `config_win` folders depending on your system.

function config_os() {
  local config_="config_"
  local os_type=$OSTYPE

  if [[ $os_type == darwin* ]]; then
    echo "${config_}mac"
  elif [[ $os_type == msys* ]]; then
    echo "${config_}win"
  fi

  echo "${config_}linux"
}

JAR="$HOME/.config/nvim/pack/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME=$HOME/.gradle $JAVA11_HOME/bin/java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  ${comment# -javaagent:"$HOME/.m2/repository/org/projectlombok/lombok/1.18.20/lombok-1.18.20.jar"} \
  ${comment# -Xbootclasspath/a:"$HOME/.m2/repository/org/projectlombok/lombok/1.18.21/lombok-1.18.20.jar"} \
  -jar $(echo "$JAR") \
  -configuration "$HOME/.config/nvim/pack/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/$(config_os)" \
  -data "${1:-$HOME/.config/nvim/workspace}" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
