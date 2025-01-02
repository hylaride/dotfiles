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
export AWS_PAGER=""
export ZSH_COMPDUMP="${HOME}/.cache/.zcompdump-${ZSH_VERSION}"

# Oh-my-zsh stuff
if [[ ! -a ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi
if [[ ! -a ~/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi
DISABLE_UPDATE_PROMPT=true

# User configuration
export PATH="$HOME/.tfenv/bin:/usr/local/sbin:/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/curl/bin:$PATH"

# Fixes some annoying local shit if my source machine is set to canadian locale
export  LC_CTYPE="en_US.UTF-8"

# Homeshick
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
source $HOME/.homesick/repos/homeshick/homeshick.sh

# Install vim plugins, if not already done
if [[ ! -d ~/.vim/plugged ]]; then
  vim +PlugInstall +qall
fi

# On my desktop I source custom stuff here (eg credential env vars I don't want in git)
if [[ ! -a ~/.localenv.zsh ]]; then
  touch ~/.localenv.zsh
fi
source ~/.localenv.zsh

export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv 1>/dev/null 2>&1; then
   eval "$(pyenv init -)"
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
plugins=(git zsh-autosuggestions brew macos docker nmap python tmux sudo pip postgres)
ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

if [[ "$(uname)" == "Darwin" ]]; then
  unset SSH_AUTH_SOCKET # even doing a conditional ssh-add list will have the macos native ssh-agent started
  ssh_env_cache="$HOME/.ssh/environment-$SHORT_HOST"
  if [[ -f "$ssh_env_cache" ]]; then
    . "$ssh_env_cache" > /dev/null
    # Test if $SSH_AUTH_SOCK is visible
    zmodload zsh/net/socket
    if [[ -S "$SSH_AUTH_SOCK" ]] && zsocket "$SSH_AUTH_SOCK" 2>/dev/null; then
      if [[ "$(ssh-add -l)" =~ "no identities" ]]; then
        /usr/bin/ssh-add --apple-load-keychain > /dev/null 2>&1
      fi
    else
      export SSH_ASKPASS=/opt/homebrew/bin/ssh-askpass
      export DISPLAY=localhost:0.0
      ssh-agent -s | sed '/^echo/d' >! "$ssh_env_cache"
      chmod 600 "$ssh_env_cache"
      . "$ssh_env_cache" > /dev/null
      /usr/bin/ssh-add --apple-load-keychain > /dev/null 2>&1
    fi
  else
    export SSH_ASKPASS=/opt/homebrew/bin/ssh-askpass
    export DISPLAY=localhost:0.0
    ssh-agent -s | sed '/^echo/d' >! "$ssh_env_cache"
    chmod 600 "$ssh_env_cache"
    . "$ssh_env_cache" > /dev/null
    /usr/bin/ssh-add --apple-load-keychain > /dev/null 2>&1
  fi
fi

#Aliases
alias agent_ssh_sync='eval $(tmux show-env -s |grep '^SSH_')' # get forwaded agent key after re-attaching in tmux
alias apt-all='sudo apt-get update && sudo apt-get dist-upgrade --purge -y && sudo apt-get autoremove --purge -y && sudo apt-get update'
alias agal-inst='ansible-galaxy install -r requirements.yml -f'
alias git-cleanall='git checkout main && git pull && git remote prune origin'
alias update-zsh-deps='(homeshick pull && cd ~/.oh-my-zsh && git pull && cd custom/plugins/zsh-autosuggestions && git pull && cd ../../themes/powerlevel10k && git pull)'
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## END: Some things tend to append after here, eg aws-sso-cli
