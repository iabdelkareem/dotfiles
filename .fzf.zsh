# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ibrahim/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ibrahim/.fzf/bin"
fi

# Auto-completion
# ---------------
#[[ $- == *i* ]] && source "/home/ibrahim/.fzf/shell/completion.zsh" 2> /dev/null

source "/home/ibrahim/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/home/ibrahim/.fzf/shell/key-bindings.zsh"

export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type d'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
