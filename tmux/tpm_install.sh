#!usr/bin/bash
# https://github.com/tmux-plugins/tpm

if [[ -d ~/.tmux/plugins/tpm ]]; then
   echo "TPM already installed" 
   exit 0
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
