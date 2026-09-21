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
  networking.interfaces.enp12s0 = {
    useDHCP = false;
    wakeOnLan.enable = true;
  };
  networking.networkmanager.unmanaged = [
    "interface-name:enp12s0"
  ];
}
