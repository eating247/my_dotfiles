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

# pure prompt
autoload -U promptinit; promptinit
prompt pure

export VISUAL=nvim
export EDITOR="$VISUAL"
export AWS_DEFAULT_REGION=‘us-east-1’
export AWS_REGION='us-east-1'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

function fd() {
  (cd ~/code/spreeworks/ops && bundle exec bin/fd $*)
}

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
