# Desktop machine-specific configuration
{
  config,
  pkgs,
  lib,
  ags,
  ...
}:

{
  networking.hostName = "desktop";

  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./fstab.nix
    ../../modules/home-manager
  ];

  # DeepCool hardware control (optional)
  services.hardware.deepcool-digital-linux =  {
    enable = true;
    extraArgs = [
      "--mode"
      "auto"
    ];
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

}
