{ config, pkgs, lib, osConfig ? {}, dotfiles, gruvshell, ... }:

{
  home.stateVersion = "25.11";
  home.sessionVariables.NIXOS_PRUNE_DAYS = "30";
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;

  home.file.".config/wallpapers".source = "${dotfiles}/wallpapers";

  home.file.".config/hypr/hyprland.conf".source = "${dotfiles}/hyprland/.config/hypr/hyprland.conf";
  home.file.".config/hypr/hyprlock.conf".source = "${dotfiles}/hyprland/.config/hypr/hyprlock.conf";
  home.file.".config/hypr/hyprpaper.conf".source = "${dotfiles}/hyprland/.config/hypr/hyprpaper.conf";

  #Machine-specific monitor configuration
  #My monitors have different scaling needs
  home.file.".config/hypr/monitors.conf".source =
    if (osConfig.networking.hostName or config.home.username) == "ph315"
    then "${dotfiles}/hyprland/.config/hypr/monitors-laptop.conf"
    else "${dotfiles}/hyprland/.config/hypr/monitors-desktop.conf";

  #Direct symlink so package-lock.json can be edited independently
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
  
  home.file.".config/kitty".source = "${dotfiles}/kitty/.config/kitty";
  home.file.".config/fastfetch".source = "${dotfiles}/fastfetch/.config/fastfetch";
  home.file.".config/quickshell".source = gruvshell;
  home.packages = with pkgs; [
    meslo-lgs-nf
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

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
      theme = "robbyrussell";
      plugins = [
        "git"
        "sudo"
        "command-not-found"
      ];
    };

    plugins = [
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


}
