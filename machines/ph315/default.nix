# Laptop machine-specific configuration
{ config, pkgs, lib, ags, ... }:

{
  networking.hostName = "ph315";

  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../modules/home-manager
  ];
  # Use lts kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_18;

}
