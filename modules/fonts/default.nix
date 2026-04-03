{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
    meslo-lgs-nf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
