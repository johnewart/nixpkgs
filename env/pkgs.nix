{ jdk }:

let
  #pinned = import ./pinned.nix;
  pkgs = import ./config.nix { inherit jdk; };
  # if we want to configure a new version of terraform which isn't available
  # yet, we could use an overlay. eg.
  # overlays = [
  #    (import ./terraform.nix)
  #];
  # pkgs   = import pinned.nixpkgs { inherit config; inherit overlays;};
  pkgs   = import pinned.nixpkgs { inherit config;};
in
  pkgs
