{ pkgs }:

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
]
