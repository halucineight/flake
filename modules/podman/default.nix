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

      environment.systemPackages = basePkgs;

    };
}
