#!/usr/bin/env bash
set -euxo pipefail

start_rails() {
  if [ -d "rails" ]; then cd rails
    bin/setup
  else
    echo "No Rails app found"
  fi
}

start_react_native() {
  if [ -d "react-native" ]; then
    cd react-native
    npm install
    npm run start
  else
    echo "No react native app found"
  fi
}

start_rails &>rails.log 2>&1
rails_pid=$!
start_react_native &>react-native.log 2>&1
react_native_pid=$!
echo "Rails is running on port 3000 and react native on port 8081.\nYou can follow their logs by running tail -f rails.log and tail -f react-native.log"
