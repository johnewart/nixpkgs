
{ pkgs, lib, config, ... }:

{

  imports = [
    ./common.nix
    ./modules/latex.nix
  ];

  host.profile.environment = "personal";
  
  home.username = "jewart";
  home.homeDirectory = "/Users/jewart";
  home.stateVersion = "22.05";
  
  home.packages = [                              
    pkgs.htop
    pkgs.fortune
    pkgs.nodejs
    pkgs.nodePackages.npm 
    pkgs.nodePackages.yarn
    pkgs.maven
  ];

  programs.git = { 
    userName = "John Ewart";
    userEmail = "john@johnewart.net";
  };
}
