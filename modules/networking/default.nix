{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking.hostName = lib.mkDefault "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  networking.firewall.enable = true;
}
