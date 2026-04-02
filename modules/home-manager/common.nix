{ config, pkgs, lib, osConfig ? {}, ags, dotfiles, ags-shell, ... }:

{
  imports = [ ags.homeManagerModules.default ];
 
  home.stateVersion = "25.11";
  home.sessionVariables.NIXOS_PRUNE_DAYS = "30";
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;

  home.file.".p10k.zsh".source = "${dotfiles}/zsh/.p10k.zsh";

  home.file.".config/wallpapers".source = "${dotfiles}/wallpapers";

  home.file.".config/hypr/hyprland.conf".source = "${dotfiles}/hyprland/.config/hypr/hyprland.conf";
  home.file.".config/hypr/hyprlock.conf".source = "${dotfiles}/hyprland/.config/hypr/hyprlock.conf";
  home.file.".config/hypr/hyprpaper.conf".source = "${dotfiles}/hyprland/.config/hypr/hyprpaper.conf";

  #Machine-specific monitor configuration
  #My monitors have different scaling needs
  home.file.".config/hypr/monitors.conf".source =
    if (osConfig.networking.hostName or config.home.username) == "laptop"
    then "${dotfiles}/hyprland/.config/hypr/monitors-laptop.conf"
    else "${dotfiles}/hyprland/.config/hypr/monitors-desktop.conf";

  #Direct symlink so package.json can be edited independently
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/nvim/.config/nvim";

  home.file.".config/fuzzel".source = "${dotfiles}/fuzzel/.config/fuzzel";

  home.file.".config/yazi".source = "${dotfiles}/yazi/.config/yazi";


  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita";
      icon-theme = "Papirus";
      cursor-theme = "breeze_cursors";
    };
  };

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "breeze_cursors";
      package = pkgs.kdePackages.breeze;
    };

    font = {
      name = "Noto Sans";
      size = 10;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-button-images = true;
      gtk-cursor-blink = true;
      gtk-cursor-blink-time = 1000;
      gtk-decoration-layout = "icon:minimize,maximize,close";
      gtk-enable-animations = true;
      gtk-menu-images = true;
      gtk-modules = "colorreload-gtk-module:window-decorations-gtk-module";
      gtk-primary-button-warps-slider = true;
      gtk-sound-theme-name = "ocean";
      gtk-toolbar-style = 3;
      gtk-xft-dpi = 98304;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-cursor-blink = true;
      gtk-cursor-blink-time = 1000;
      gtk-decoration-layout = "icon:minimize,maximize,close";
      gtk-enable-animations = true;
      gtk-modules = "colorreload-gtk-module:window-decorations-gtk-module";
      gtk-primary-button-warps-slider = true;
      gtk-sound-theme-name = "ocean";
      gtk-xft-dpi = 98304;
    };
  };

  home.file.".config/kitty".source = "${dotfiles}/kitty/.config/kitty";
  home.file.".config/fastfetch".source = "${dotfiles}/fastfetch/.config/fastfetch";
  home.packages = with pkgs; [
    meslo-lgs-nf
  ];

  #ZSH
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;

    sessionVariables = {
      EDITOR = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "command-not-found"
      ];
      custom = "$HOME/.oh-my-zsh-custom";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
        file = "share/zsh-completions/zsh-completions.plugin.zsh";
      }
    ];

  };

  #AGS
  programs.ags = {
    enable = true;
    configDir = ags-shell;
    extraPackages = [
      ags.packages.${pkgs.stdenv.hostPlatform.system}.apps
      ags.packages.${pkgs.stdenv.hostPlatform.system}.battery
      ags.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
      ags.packages.${pkgs.stdenv.hostPlatform.system}.network
      ags.packages.${pkgs.stdenv.hostPlatform.system}.tray
      ags.packages.${pkgs.stdenv.hostPlatform.system}.wireplumber
    ];
  };
  
}
