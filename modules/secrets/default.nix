{ pkgs, ... }:

{
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;
  security.pam.services.sddm.enableGnomeKeyring = true;
}
