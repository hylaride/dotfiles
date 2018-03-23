# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export ANSIBLE_HOST_KEY_CHECKING=False

# Oh-my-zsh stuff
if [[ ! -a ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi
#
# Source python2 env, if it exists
if [[ -d ~/.p2-env-main ]]; then
  source ~/.p2-env-main/bin/activate
fi

# User configuration
export PATH="$PATH:$HOME/.tfenv/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin"

# Fixes some annoying local shit if my source machine is set to canadian locale
export  LC_CTYPE="en_US.UTF-8"

# Homeshick
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
source $HOME/.homesick/repos/homeshick/homeshick.sh 

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/node@6/bin:$PATH"

# Install vim plugins, if not already done
if [[ ! -d ~/.vim/plugged ]]; then
  vim +PlugInstall +qall
fi

# On my desktop I source custom stuff here
if [[ ! -a ~/.localenv.zsh ]]; then
  touch ~/.localenv.zsh 
fi
source ~/.localenv.zsh

if [[ ! -a  ~/.config/base16-shell ]]; then
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

base16_default-dark

ZSH_THEME="agnoster"
COMPLETION_WAITING_DOTS="true"
plugins=(git aws zsh-autosuggestions brew docker nmap osx pyenv python tmux sudo pip postgres)

source $ZSH/oh-my-zsh.sh

#Aliases
alias agent_ssh_sync='eval $(tmux show-env -s |grep '^SSH_')' # get forwaded agent key after re-attaching in tmux
