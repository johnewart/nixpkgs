{ config, pkgs, ... }:

{

  imports = [
    ./common.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "johnewart";
  home.homeDirectory = "/home/johnewart";
 

  home.packages = [     
    pkgs.htop
    pkgs.fortune
    pkgs.zsh
  ];

  programs.git = {
    enable = true;
    userName = "John Ewart";
    userEmail = "johnewart@microsoft.com";
  };

  ##services.gpg-agent = { 
  #  enable = true;
  #  defaultCacheTtl = 1800;
  #  enableSshSupport = true;
  #};

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
