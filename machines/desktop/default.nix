# resktop machine-specific configuration
{
  config,
  pkgs,
  lib,
  ags,
  ...
}:

{
  networking.hostName = "desktop";
  networking.firewall.allowedTCPPorts = [
    3001
    8080
  ];

  services.openssh.enable = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  networking.interfaces.enp12s0 = {
    useDHCP = false;
    wakeOnLan.enable = true;
  };

  imports = [
    ./users.nix
    ./hardware-configuration.nix
    ./nvidia.nix
    ./fstab.nix
    ../../modules/home-manager
    ./services.nix
    ./modules/sniffnet/default.nix
  ];

  #Packages and services specific to this computer will go here:
  #If the list gets too long I'll create a new file
  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
    gimp
    python313
    localsend
    nixos-firewall-tool
    losslesscut-bin
    bubblewrap
  ];

  services.hardware.deepcool-digital-linux = {
    enable = false;
    extraArgs = [
      "--mode"
      "auto"
    ];
  };
  programs.nh = {
    enable = true;
    flake = "path:/home/halucineight/flake";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

}
