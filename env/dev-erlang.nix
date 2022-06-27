let
  # get a normalized set of packages, from which
  # we will install all the needed dependencies
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    buildInputs = [
      pkgs.elixir
      pkgs.beamPackages.rebar3
      pkgs.beamPackages.hex
      pkgs.darwin.apple_sdk.frameworks.CoreServices
      pkgs.darwin.apple_sdk.frameworks.SystemConfiguration
    ];
    shellHook = ''
      export NIX_ENV=dev
    '';
  }
