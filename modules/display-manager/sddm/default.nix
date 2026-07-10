{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = false;

  # Prevent KDE from overriding GTK theme settings
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kde-gtk-config
  ];
}
