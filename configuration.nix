{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./modules/bootloader/default.nix
    ./modules/users/default.nix
    ./modules/networking/default.nix
    ./modules/apps/default.nix
    ./modules/wm/hyprland/default.nix
    ./modules/display-manager/sddm/default.nix
    ./modules/audio/pipewire/default.nix
    ./modules/power/upower/default.nix
    ./modules/ssh/default.nix
    ./modules/devshell/default.nix
    ./modules/flatpak/default.nix
    ./modules/bluetooth/default.nix
    ./modules/podman/default.nix
    ./packages/default.nix
    ./modules/mullvad/default.nix
    ./modules/thunar/default.nix
    ./modules/fonts/default.nix
    ./overlays/default.nix
    ./nix.nix
    ./local.nix
  ];

  time.timeZone = lib.mkDefault "Etc/UTC";

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05";
}
