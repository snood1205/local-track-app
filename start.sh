#!/usr/bin/env bash
set -euo pipefail

RAILS_LOG=$(pwd)/rails.log
REACT_NATIVE_LOG=$(pwd)/react-native.log

start_rails() {
  if [ -d "rails" ]; then 
    cd rails
    bin/setup >$RAILS_LOG 2>&1
  else
    echo "No Rails app found"
  fi
}

start_react_native() {
  if [ -d "react-native" ]; then
    cd react-native
    npm install >$REACT_NATIVE_LOG 2>&1
    npm run start >$REACT_NATIVE_LOG 2>&1
  else
    echo "No react native app found"
  fi
}

print_info() {
  echo "Rails is running on port 3000 and react native on port 8081."
  echo "You can follow their logs by running \`tail -f rails.log\` and \`tail -f react-native.log\`"
}
(trap 'kill 0' SIGINT; start_rails & start_react_native & print_info & wait)
