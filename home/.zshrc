# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export ANSIBLE_HOST_KEY_CHECKING=False

if [[ ! -a ~/.localenv.zsh ]]; then
   touch ~/.localenv.zsh 
fi

source ~/.localenv.zsh

# Oh-my-zsh stuff

ZSH_THEME="agnoster"
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-autosuggestions aws brew docker nmap osx pyenv postgres)

# User configuration

export PATH="$PATH:$HOME/.tfenv/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin"
source $ZSH/oh-my-zsh.sh

export  LC_CTYPE="en_US.UTF-8"

# Homeshick
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
source $HOME/.homesick/repos/homeshick/homeshick.sh 

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/node@6/bin:$PATH"

if [[ -d ~/.p2-env-main ]]; then
   source ~/.p2-env-main/bin/activate
fi
