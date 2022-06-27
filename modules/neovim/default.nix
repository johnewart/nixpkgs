{ config, pkgs, lib, ... }:
{


nixpkgs.overlays = [
  (import (builtins.fetchTarball {
    url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  }))
];

  #home.packages = with pkgs; [
  #  lua
  #  rnix-lsp
  #  rust-analyzer
  #  vale
  #  shellcheck
  #  gopls
  #  stylua
  #  nodePackages.pyright
  #  sumneko-lua-language-server
  #];

  programs.neovim = {
   enable = true; 
   package = pkgs.neovim-nightly; 
   extraConfig = builtins.concatStringsSep "\n" [
      #(lib.strings.fileContents ./base.vim)
      #(lib.strings.fileContents ./plugins.vim)
      #(lib.strings.fileContents ./lsp.vim)

      # this allows you to add lua config files
      ''
        lua << EOF
        ${lib.strings.fileContents ./config.lua}
        EOF
      ''
    ];

    extraPackages = with pkgs; [
      # used to compile tree-sitter grammar
      tree-sitter

      # installs different langauge servers for neovim-lsp
      # have a look on the link below to figure out the ones for your languages
      # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
      nodePackages.typescript nodePackages.typescript-language-server
      gopls
      nodePackages.pyright
      rust-analyzer
    ];
  };

  xdg.dataHome = "${config.home.homeDirectory}/.data";
  # fzf-native
  xdg.dataFile."nvim/site/pack/packer/start/telescope-fzf-native.nvim/build/libfzf.so".source = "${pkgs.vimPlugins.telescope-fzf-native-nvim}/share/vim-plugins/telescope-fzf-native-nvim/build/libfzf.so";
  # tree-sitter parsers
  #xdg.configFile."nvim/init.lua".source = ./init.lua;
  xdg.configFile."nvim/lua".source = ./lua;
  xdg.configFile."nvim/parser/c.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
  xdg.configFile."nvim/parser/lua.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
  xdg.configFile."nvim/parser/rust.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
  xdg.configFile."nvim/parser/python.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
  
  #xdg.configFile."nvim/init.lua".onChange = "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'";

  programs.zsh.shellAliases  = {
    vim = "nvim";
    vi = "nvim";
  };


}
