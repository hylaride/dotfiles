# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export ANSIBLE_HOST_KEY_CHECKING=False
export VIRTUAL_ENV_DISABLE_PROMPT=0
export AWS_VAULT_KEYCHAIN_NAME=login

# Oh-my-zsh stuff
if [[ ! -a ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi
if [[ ! -a ~/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi
DISABLE_UPDATE_PROMPT=true

# User configuration
export PATH="$PATH:$HOME/.tfenv/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:/opt/homebrew/sbin"

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

export PYENV_ROOT="$HOME/.pyenv/shims"
export PATH="$PYENV_ROOT:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
   eval "$(pyenv virtualenv-init -)"
fi

if [[ ! -a  ~/.config/base16-shell ]]; then
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-autosuggestions brew docker nmap macos python tmux sudo pip postgres)

ZSH_DISABLE_COMPFIX="true"
source $ZSH/oh-my-zsh.sh

#Aliases
alias agent_ssh_sync='eval $(tmux show-env -s |grep '^SSH_')' # get forwaded agent key after re-attaching in tmux

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
