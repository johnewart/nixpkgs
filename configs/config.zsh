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

