# Aliases
alias ls="lsd --oneline"
alias cat="bat --plain"
alias python=python3
alias sbsd="sam build && sam deploy"
alias oil="nvim +Oil"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install

#Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# source $HOME/personal/repos/zsh-autocomplete/zsh-autocomplete.plugin.zsh
zstyle :compinstall filename '/home/ibrahim/.zshrc'
autoload bashcompinit; bashcompinit
autoload -Uz compinit; compinit
_comp_options+=(globdots) # With hidden files

_dotnet_zsh_complete() 
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

compdef _dotnet_zsh_complete dotnet
complete -C "/usr/local/bin/aws_completer" aws

zinit light Aloxaf/fzf-tab

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

#source ~/.config/.zsh/zinit.zsh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source <(kubectl completion zsh)

#eval "$(register-python-argcomplete /etc/bash_completion.d/az.completion)"
#sudo ip link set dev eth0 mtu 1350

zinit ice depth=1;zinit light jeffreytse/zsh-vi-mode
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
setopt extendedglob nomatch notify HIST_SAVE_NO_DUPS
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
unsetopt autocd beep
bindkey -v

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# rclone --vfs-cache-mode writes mount "onedrive": /home/ibrahim/personal/onedrive

ZSH_AUTOSUGGEST_STRATEGY=(completion history)
bindkey '^ ' autosuggest-accept

zmodload zsh/zpty

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# timedatectl set-local-rtc 1 --adjust-system-clock
### End of Zinit's installer chunk

# Start Agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

setopt AUTO_CONTINUE
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias vw="sudo ~/work/start-vpn.sh"
alias systeminfo=neofetch
alias calc=/usr/bin/bc

function() {
  local bluetooth_headphones="80:C3:BA:4A:30:8B"
  alias bc="bluetoothctl unblock $bluetooth_headphones; bluetoothctl connect $bluetooth_headphones;"
  alias bd="bluetoothctl disconnect $bluetooth_headphones; bluetoothctl block $bluetooth_headphones;" 
}

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

