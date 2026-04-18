if [[ "$(uname)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH="$HOME/.local/bin:$HOME/Library/Python/3.13/bin:$(brew --prefix llvm)/bin:$PATH"

if [[ -z "$SSH_CLIENT" && -z "$SSH_TTY" ]]; then
  # Use robbyrussell on local system
  ZSH_THEME="robbyrussell"
else
  # Use a custom theme later on remote systems
  ZSH_THEME=""
fi

export ZSH="$HOME/.oh-my-zsh"
plugins=(git z)
source $ZSH/oh-my-zsh.sh

# Custom Theme
if [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
  # Show hostname on remote systems
  PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[yellow]%}%n@%m %{$fg[cyan]%}%c%{$reset_color%}"
  PROMPT+=' $(git_prompt_info)'
  ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
  ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
fi

# User configuration
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS      
setopt HIST_IGNORE_SPACE    
setopt SHARE_HISTORY        

# Other Plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Exports
export EDITOR="nvim"
export VISUAL="nvim"

# Aliases
alias v="nvim"
alias ls="eza"
alias ll="eza -la --icons"
alias lt="eza --tree --icons"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

autoload -U promptinit; promptinit

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
