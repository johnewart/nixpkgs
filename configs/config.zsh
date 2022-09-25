function dev-env {
    nix-shell ~/.config/nixpkgs/env/dev-${1}.nix
}

export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

#_nixenv() {
#  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIPENV_COMPLETE=complete-zsh pipenv)
#}
#compdef _pipenv pipenv


# Automatically run nix-shell
_toggleNixShell() {
  # deactivate shell if default.nix doesn't exist and not in a subdir
  if [[ ! -f "$PWD/default.nix" ]]; then
    if [[ ! -z "$NIXSHELL_ACTIVE" ]]; then 
      if [[ "$PWD" != "$nixfile_dir"* ]]; then
        echo "Left NIX project dir, exiting nix-shell"
        exit
      fi
    fi
  fi

  if [[ "$NIXSHELL_ACTIVE" != "1" ]]; then
    if [[ -f "$PWD/default.nix" ]]; then
      export nixfile_dir="$PWD"
      export NIXSHELL_ACTIVE="1"
      export ZSH_THEME="amuse"
      echo "Loading NIX environment from ${PWD}/default.nix"
      nix-shell
      
      unset NIXSHELL_ACTIVE
      unset nixfile_dir 
    fi
  fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _toggleNixShell
_toggleNixShell


alias cz="chezmoi"

export BREW_PREFIX="/opt/homebrew"
export CELLAR="$BREW_PREFIX/Cellar"
export JAVA_HOME="$CELLAR/openjdk@11/11.0.14.1"
export GO_HOME=${GO_HOME:-$CELLAR/go/1.18.4}
export EMACS_HOME="$HOME/.emacs.d"
export QT_HOME="$BREW_PREFIX/opt/qt5"
export DOTNET_HOME="/usr/local/share/dotnet"
export COURSIER_HOME="$HOME/Library/Application Support/Coursier"
export RANCHER_HOME="$HOME/.rd"

export PATH="$PATH:$HOME/.cargo/bin:$JAVA_HOME/bin:$GO_HOME/bin:$EMACS_HOME/bin:$COURSIER_HOME/bin:$QT_HOME/bin:$BREW_PREFIX/bin:$RANCHER_HOME/bin:$DOTNET_HOME"

function edit_dotfiles() {
       if (( $# == 0 ))
       then echo usage: edit_dotfiles path ...; fi
       for i; do 
	chezmoi edit $i 
        echo "Committing changes to $i..."
	( cd $HOME/.local/share/chezmoi && git add . && git commit -m "Update to $i")
        ( cd $HOME/.local/share/chezmoi && git push origin main)
       done

       echo "Reloading ZSH config..."      
       source ~/.zshrc
}

function sync_dotfiles() {
   cd $HOME/.local/share/chezmoi
   git prom
   echo "Reloading ZSH config..."
   source ~/.zshrc
}

CONDA_PREFIX="$HOME/.miniforge"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda activate home

eval "$(/usr/libexec/path_helper)"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH=$PATH:$HOME/.dapr/bin
#export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
#export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

alias be="bundle exec"

