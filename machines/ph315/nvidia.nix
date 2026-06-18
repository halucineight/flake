{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia-container-toolkit.enable = false;
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;

    # Cause GTX 1050Ti does not work with open drivers

    open = false;

    # 580.XX.XX is the last supported driver version for 1050Ti. Sed :(
    branch = "legacy_580";

    powerManagement.enable = true;
  };
}
