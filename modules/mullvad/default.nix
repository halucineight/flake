{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.services;
in
{
  options = {
    services.enableMullvad = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Mullvad service + GUI";
    };
  };

  config = lib.mkIf cfg.enableMullvad {
    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.enableExcludeWrapper = true;
    services.mullvad-vpn.package = pkgs.mullvad-vpn;

  };
}
