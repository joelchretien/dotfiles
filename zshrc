# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        if [ ${config:e} = "zwc" ] ; then continue ; fi
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [[ -f $config && ${config:e} != "zwc" ]]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        if [ ${config:e} = "zwc" ] ; then continue ; fi
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

export PATH="$HOME/.composer/vendor/bin:$HOME/.rbenv/bin:$PATH"
export XDEBUG_CONFIG="idekey=VSCODE"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

#eval "$(rbenv init -)"
#
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

#Enable vi mode
bindkey -v

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="blinks"

plugins=(
  git
  tmux
  docker
  laravel5
  vi-mode
  fzf
)

source $ZSH/oh-my-zsh.sh
#oh-my-zsh attempts to alias g.  We already have a function that does this.
unalias g &>/dev/null

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

[[ -f ~/knak-scripts/aliases ]] && source ~/knak-scripts/aliases
export ENTERPRISE_REPO_PATH=~/projects/enterprise/
[[ -f ~/projects/enterprise/scripts/aliases ]] && source ~/projects/enterprise/scripts/aliases


export OBSIDIAN_REPO_PATH=~/projects/obsidian-mvp/
[[ -f ~/projects/obsidian-mvp/scripts/aliases ]] && source ~/projects/obsidian-mvp/scripts/aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
source /usr/share/nvm/init-nvm.sh
