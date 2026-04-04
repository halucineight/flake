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
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "580.119.02";
      sha256_64bit = "sha256-gCD139PuiK7no4mQ0MPSr+VHUemhcLqerdfqZwE47Nc=";
      sha256_aarch64 = "sha256-eYcYVD5XaNbp4kPue8fa/zUgrt2vHdjn6DQMYDl0uQs=";
      openSha256 = "sha256-l3IQDoopOt0n0+Ig+Ee3AOcFCGJXhbH1Q1nh1TEAHTE=";
      settingsSha256 = "sha256-sI/ly6gNaUw0QZFWWkMbrkSstzf0hvcdSaogTUoTecI=";
      persistencedSha256 = "sha256-j74m3tAYON/q8WLU9Xioo3CkOSXfo1CwGmDx/ot0uUo=";
    };

    powerManagement.enable = true;
  };
}

