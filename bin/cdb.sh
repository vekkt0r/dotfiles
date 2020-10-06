#!/bin/bash

# Helper for creating compile_commands.json with compiledb, adding header entries with compdb

root=$PWD
cd $1
bexec compiledb -e '.*/3pp/.*' -e '.*/dist/.*' make -C $1 V=1 BUILD_TEST=false -w local_all
sed -i '/"-M[DPFT]", $/d' compile_commands.json
sed -i '/"\.depfiles.*", $/d' compile_commands.json
#sed -i 's/-MD -MP -MF .* //g' compile_commands.json
compdb -p . list > tmp_commands
mv tmp_commands compile_commands.json.new

if [ -e ${root}/compile_commands.json ]; then
  jq -s '.|flatten' ${root}/compile_commands.json compile_commands.json.new > tmp_commands
  rm compile_commands.json.new
else
  mv compile_commands.json.new tmp_commands
fi

mv tmp_commands ${root}/compile_commands.json
