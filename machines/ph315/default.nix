# Laptop machine-specific configuration
{ config, pkgs, lib, ags, ... }:

{
  networking.hostName = "laptop";

  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../modules/home-manager
  ];
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_18;

}
