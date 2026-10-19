{ modulesPath, pkgs, ... }:

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  disabledModules = [ "${modulesPath}/profiles/base.nix" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "halupie";
  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "server";
    extraSetFlags = [ "--advertise-routes=192.168.29.0/24" ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      PermitEmptyPasswords = false;
    };
  };

  nix.settings = {
    trusted-users = [ "piman" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    max-jobs = 1;
    cores = 1;
  };
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  zramSwap.enable = true;

  users.users.piman = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    initialHashedPassword = "";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBWSsSSdAcrPqfVPbL1OmaTG2sRhkKzwrxFECPotYT6h halucineight@nixos-desktop"
    ];
  };

  environment.systemPackages = with pkgs; [
    busybox
    vim
    git
    nh
  ];

  environment.shellAliases.wakedesktop =
    "sudo ${pkgs.busybox}/bin/busybox ether-wake -b -i end0 04:7c:16:d7:12:12";

  system.stateVersion = "26.05";
}
