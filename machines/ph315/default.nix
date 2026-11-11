# Laptop machine-specific configuration
{
  config,
  pkgs,
  lib,
  ags,
  ...
}:

{
  networking.hostName = "ph315";

  imports = [
    ./users.nix
    ./hardware-configuration.nix
    ./disko.nix
    ./nvidia.nix
    ../../modules/home-manager
  ];
  # Use lts kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.nh = {
    enable = true;
    flake = "path:/home/halucineight/flake";
  };

}
