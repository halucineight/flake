# Desktop machine-specific configuration
{ config
, pkgs
, lib
, ags
, ...
}:

{
  networking.hostName = "desktop";

  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./fstab.nix
    ../../modules/home-manager
  ];

  #Packages and services specific to this computer will go here:
  #If the list gets too long I'll create a new file
  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
  ];

  services.hardware.deepcool-digital-linux = {
    enable = true;
    extraArgs = [
      "--mode"
      "auto"
    ];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

}
