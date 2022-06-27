{ pkgs, lib, config, ... }:

{
  imports = [
    ./common.nix
  ];
  
  home.username = "ubuntu";
  home.homeDirectory = "/home/ubuntu";
  home.stateVersion = "22.05";
  
  home.packages = [                              
    pkgs.fortune
    pkgs.kubernetes-helm
    pkgs.lastpass-cli
  ];

    programs.git = { 
    userName = "John Ewart";
    userEmail = "johnewart@falconx.io";
  };
}
