{ go ? "go_1_17" }:

let
  # get a normalized set of packages, from which
  # we will install all the needed dependencies
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    buildInputs = [
      pkgs.${go}
    ];
    shellHook = ''
      export NIX_ENV=dev
    '';
  }

