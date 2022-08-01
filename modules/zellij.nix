{ pkgs, config, lib, ... }:

{
  home.file.".config/zellij/config.yaml".text = ''
theme: catppuccin
themes:
  catppuccin:
    bg:
    - 48
    - 45
    - 65
    black:
    - 22
    - 19
    - 32
    blue:
    - 150
    - 205
    - 251
    cyan:
    - 26
    - 24
    - 38
    fg:
    - 217
    - 224
    - 238
    gray:
    - 87
    - 82
    - 104
    green:
    - 171
    - 233
    - 179
    magenta:
    - 245
    - 194
    - 231
    orange:
    - 248
    - 189
    - 150
    red:
    - 242
    - 143
    - 173
    white:
    - 217
    - 224
    - 238
    yellow:
    - 250
    - 227
    - 176
    '';
  }
