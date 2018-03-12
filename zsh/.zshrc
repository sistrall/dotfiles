# Initialize Prezto
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

autoload -Uz promptinit
promptinit
prompt pure

# Vagrant aliases
# alias vu='vagrant up'
# alias vs='vagrant ssh'
# alias vh='vagrant halt'