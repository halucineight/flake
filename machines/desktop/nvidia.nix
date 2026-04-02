{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia-container-toolkit.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;

    open = false;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    powerManagement.enable = true;
  };
}

