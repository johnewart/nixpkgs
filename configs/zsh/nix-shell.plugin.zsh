#_nixenv() {
#  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIPENV_COMPLETE=complete-zsh pipenv)
#}
#compdef _pipenv pipenv


# Automatically run nix-shell
_toggleNixShell() {
  # deactivate shell if default.nix doesn't exist and not in a subdir
  if [[ ! -f "$PWD/default.nix" ]]; then
    if [[ "$NIXSHELL_ACTIVE" == 1 ]]; then
      if [[ "$PWD" != "$nixfile_dir"* ]]; then
        echo "Not in a NIX project dir, leaving shell!"
        exit

      fi
    fi
  fi

  # activate the shell if Pipfile exists
  if [[ "$NIXSHELL_ACTIVE" != 1 ]]; then
    if [[ -f "$PWD/default.nix" ]]; then
      export nixfile_dir="$PWD"
      echo "Loading NIX environment from ${PWD}/default.nix"
      nix-shell
    fi
  fi
}
#autoload -U add-zsh-hook
#add-zsh-hook chpwd _toggleNixShell
#_toggleNixShell

