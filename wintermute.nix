{ pkgs, lib, config, ... }:

{
  imports = [
    ./common.nix
    ./modules/latex.nix
  ];

  host.profile.environment = "work";

  home.username = "johnewart";
  home.homeDirectory = "/home/johnewart";
  home.stateVersion = "22.05";
  
  home.packages = [                              
    pkgs.fortune
    pkgs.awscli2
    pkgs.ansible
    pkgs.python3
    pkgs.kubernetes-helm
    pkgs.go
    pkgs.gopls
    pkgs.rustc
    pkgs.cargo
    pkgs.lastpass-cli
  ];

  programs.git = { 
    userName = "John Ewart";
    userEmail = "johnewart@microsoft.com";
  };
}
