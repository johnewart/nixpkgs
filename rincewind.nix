{ pkgs, lib, config, ... }:

{
  imports = [
    ./common.nix
  ];
  
  home.username = "jewart";
  home.homeDirectory = "/home/jewart";
  home.stateVersion = "22.05";
  
  home.packages = [                              
    pkgs.fortune
    pkgs.kubernetes-helm
  ];

    programs.git = { 
    userName = "John Ewart";
    userEmail = "john@johnewart.net";
  };
}
