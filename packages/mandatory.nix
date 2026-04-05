{ pkgs, quickshellFlake, ...}:

#These packages don't have Nix-style services

with pkgs;
[
  vim
  neovim
  yazi
  gcc
  gnumake42
  libgcc
  nixd
  nixfmt
  zsh
  kitty
  wget
  htop
  psmisc
  unzip
  ripgrep
  git
  git-filter-repo
  waybar
  hyprpaper
  hyprlock
  grimblast
  wlogout
  brightnessctl
  fuzzel
  pipewire
  pulseaudio
  wireplumber
  bluez
  blueman
  networkmanagerapplet
  gnome-keyring
  libsecret
  polkit_gnome
  papirus-icon-theme
  librsvg
  eog
  exiftool
  mpv
  yt-dlp
  fastfetch
  quickshellFlake.packages.${pkgs.system}.default
  kdePackages.qtdeclarative
  lua-language-server
  stylua
  tree-sitter
  pavucontrol	
]
