{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.modules;
  basePkgs = with pkgs; [
    podman-compose
    crun
    runc
  ];
in
{
  options = {
    modules.enablePodman = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable podman";
    };
  };

  config = lib.mkIf cfg.enablePodman {

      virtualisation.containers.enable = true;
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      users.users.${config.users.primaryUser}.extraGroups = [
        "podman"
        "libvirtd"
      ];

      users.users.playground = lib.mkIf config.users.createPlaygroundUser {
        extraGroups = [ "podman" ];
      };

      environment.systemPackages = basePkgs; 

    };
}

