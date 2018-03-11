# http://bit.ly/2nAd4Op
DOTFILES_DIRECTORY ?= $(shell pwd)

# Interpolated rule names technique has been inspired by http://bit.ly/2orb4s3
DETECTED_OS ?= $(shell uname -s | tr A-Z a-z)

BACKUP_TIMESTAMP ?= $(shell date +'%Y%m%d-%H%M%S')

setup : check_dependencies softlinking

check_dependencies : check_common_dependencies check_$(DETECTED_OS)_dependencies

check_common_dependencies :
	@####
	@# Crazy comments: prefixed with @ to avoid output
	@# (from http://bit.ly/2nDE9A6 and http://bit.ly/2nyTO3G).
	
	@###
	@# Check common system dependencies
	@# 
	@# Inspired by http://bit.ly/2nzmHwK
	command -v zsh >/dev/null 2>&1 || { echo "zsh is required but it's not installed."; exit 1; }
	[ -d ~/.zprezto ] || { echo "Missing Prezto! Here it is: https://github.com/sorin-ionescu/prezto"; exit 1; }

check_darwin_dependencies :
	# No OS dependecies on macOS, at the moment

check_linux_dependencies :
	# No OS dependecies on Linux

softlinking : common_softlinking $(DETECTED_OS)_softlinking

common_softlinking :
	@###
	@# Timestamped backup directory
	mkdir -p $(DOTFILES_DIRECTORY)/backup/$(BACKUP_TIMESTAMP)

	@###
	@# Backup copies
	[ -f ~/.gitconfig ] && cp ~/.gitconfig $(DOTFILES_DIRECTORY)/backup/$(BACKUP_TIMESTAMP)
	[ -f ~/.gitignore ] && cp ~/.gitignore $(DOTFILES_DIRECTORY)/backup/$(BACKUP_TIMESTAMP)
	[ -f ~/.zshrc ] && cp ~/.zshrc $(DOTFILES_DIRECTORY)/backup/$(BACKUP_TIMESTAMP)
	[ -f ~/.zpreztorc ] && cp ~/.zpreztorc $(DOTFILES_DIRECTORY)/backup/$(BACKUP_TIMESTAMP)

	@###
	@# Softlinking, tool by tool	
	ln -sf $(DOTFILES_DIRECTORY)/git/.gitconfig ~/.gitconfig
	ln -sf $(DOTFILES_DIRECTORY)/git/.gitignore ~/.gitignore
	ln -sf $(DOTFILES_DIRECTORY)/zsh/.zshrc ~/.zshrc
	ln -sf $(DOTFILES_DIRECTORY)/prezto/.zpreztorc ~/.zpreztorc

darwin_softlinking :

linux_softlinking : 
	
