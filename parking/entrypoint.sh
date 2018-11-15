#!/bin/bash
if ! test -d ./log/entrypoint/; then
  mkdir -p ./log/entrypoint/
fi
if test -f ./tmp/pids/server.pid; then
  rm ./tmp/pids/server.pid 2>/dev/null 1>/dev/null
fi
touch ./log/entrypoint/{yarn_log_errors,npm_log_errors,bundle_log_errors,npm_log,yarn_log,bundle_log}

npm i 2>./log/entrypoint/npm_log_errors 1>./log/entrypoint/npm_log

npm rebuild 2>./log/entrypoint/npm_log_errors 1>./log/entrypoint/npm_log

yarn install 2>./log/entrypoint/yarn_log_errors 1>./log/entrypoint/yarn_log

bundle 2>./log/entrypoint/bundle_log_errors 1>./log/entrypoint/bundle_log

foreman start
