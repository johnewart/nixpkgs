{ jdk ? "jdk11" }:

let
  # get a normalized set of packages, from which
  # we will install all the needed dependencies
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    buildInputs = [
      pkgs.${jdk}
      pkgs.gradle
      pkgs.maven
      pkgs.sbt
      pkgs.jq
    ];
    shellHook = ''
      export NIX_ENV=dev
    '';
  }

