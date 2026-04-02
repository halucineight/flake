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
    withUWSM = true;
    xwayland.enable = true;
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

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;
  security.pam.services.sddm.enableGnomeKeyring = true;

  programs.ssh.startAgent = true;
  programs.ssh.agentTimeout = null;

}
