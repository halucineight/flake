{ config
, lib
, pkgs
, ...
}:

{
  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;
  programs.zsh.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.upower.enable = true;

  services.xserver.enable = true;
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = false;

  # Prevent KDE from overriding GTK theme settings
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kde-gtk-config
  ];

  # Allow networkmanager group members to manage wifi networks
  # security.polkit.enable = true;
  # security.polkit.extraConfig = ''
  #   polkit.addRule(function(action, subject) {
  #     var allowed_actions = [
  #       "org.freedesktop.NetworkManager.enable-disable-network",
  #       "org.freedesktop.NetworkManager.enable-disable-wifi",
  #       "org.freedesktop.NetworkManager.enable-disable-wwan",
  #       "org.freedesktop.NetworkManager.network-control",
  #       "org.freedesktop.NetworkManager.settings.modify.own",
  #       "org.freedesktop.NetworkManager.settings.modify.system",
  #       "org.freedesktop.NetworkManager.wifi.scan",
  #       "org.freedesktop.NetworkManager.wifi.share.open",
  #       "org.freedesktop.NetworkManager.wifi.share.protected"
  #     ];
  #     if (allowed_actions.indexOf(action.id) >= 0) {
  #       if (subject.isInGroup("networkmanager")) {
  #         return polkit.Result.YES;
  #       }
  #     }
  #   });
  # '';
}
