{ pkgs, lib, config, ... }:

with lib;

let
  myemacs = pkgs.emacs;

  treeSitterGrammars = pkgs.runCommandLocal "grammars" {} ''
    mkdir -p $out/bin
    ${lib.concatStringsSep "\n"
      (lib.mapAttrsToList (name: src: "ln -s ${src}/parser $out/bin/${name}.so") pkgs.tree-sitter.builtGrammars)};
  '';


  # list taken from here: https://github.com/emacs-tree-sitter/tree-sitter-langs/tree/e7b8db7c4006c04a4bc1fc6865ec31f223843192/repos
  # commented out are not yet packaged in nix
  langs = [
    "agda" 
    "bash" 
    "c" 
    "c-sharp" 
    "cpp" 
    "css" 
    /*"elm" */
    "fluent"
    "go" 
    /*"hcl"*/ 
    "html" 
    /*"janet-simple"*/
    "java"
    "javascript" 
    "jsdoc" 
    "json"
    "nix"
    "ocaml" 
    "python" 
    "php" 
    /*"pgn"*/ 
    "ruby" 
    "rust"
    "scala"
    #"swift"
    "typescript" 
  ];
  grammars = lib.getAttrs (map (lang: "tree-sitter-${lang}") langs) pkgs.tree-sitter.builtGrammars;
in
{
  home.file.".tree-sitter".source = (pkgs.runCommand "grammars" {} ''
    mkdir -p $out/bin
    ${lib.concatStringsSep "\n"
      (lib.mapAttrsToList (name: src: "name=${name}; ln -s ${src}/parser $out/bin/\${name#tree-sitter-}.so") grammars)};
  '');

  home.packages = with pkgs; [
    myemacs
    ripgrep
    mu
    
    gopls
    golangci-lint
    (pkgs.runCommand "gotools-${gotools.version}" { } ''
      mkdir -p $out/bin
      # skip tools colliding with binutils
      for p in ${gotools}/bin/*; do
        name=$(basename $p)
        if [[ -x "${binutils-unwrapped}/bin/$name" ]]; then
          continue
        fi
        ln -s $p $out/bin/
      done
    '')
    gotests
    reftools
    gomodifytags
    gopkgs
    impl
    godef
    gogetdoc
    rnix-lsp
    metals
    sbt
  ];

  programs.zsh.sessionVariables  = {
 	PATH = "$PATH:$HOME/.emacs.d/bin";
    EDITOR = "emacs -nw";
  };

  programs.zsh.shellAliases = {
    e = "emacs -nw";
  };

  home.file.".doom.d/init.el" = { source = ./doom.d/init.el; onChange = "doom sync"; };
  home.file.".doom.d/config.el" = { source = ./doom.d/config.el; onChange = "doom sync"; };
  home.file.".doom.d/packages.el" = { source = ./doom.d/packages.el; onChange = "doom sync"; };
  home.file.".doom.d/local.el".source = ./${config.host.profile.environment}.el;
}
