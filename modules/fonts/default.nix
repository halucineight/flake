{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
    meslo-lgs-nf
    nerd-fonts._3270
    nerd-fonts.hack
    nerd-fonts._0xproto
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
