#/bin/bash

wd=$(pwd)

# make sure this project's /bin directory is in PATH
found=false
binPath="$wd/bin"
echo $PATH | grep -q $binPath && found=true || echo "bin path not registered in PATH yet"

if [[ $found == "false" ]]; then
  echo "\n# bin for personal tools" >> ~/.zshrc
  echo "export PATH=\$PATH:$binPath" >> ~/.zshrc
fi 

# source files that define functions
index_sourced=false
grep -q "source $wd/src/index.sh" $HOME/.zshrc && index_sourced=true || echo "index not sourced yet. adding to .zshrc"

if [[ $index_sourced == "false" ]]; then
  echo "\n# source files for personal tools" >> ~/.zshrc
  echo "source $(pwd)/src/index.sh" >> ~/.zshrc
fi
