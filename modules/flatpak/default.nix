{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.modules;
in
{
  options = {
    modules.enableFlatpak = lib.mkEnableOption {
      default = false;
      description = "Enable flatpak";
    };
  };

  config = lib.mkIf cfg.enableFlatpak {
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
    xdg.portal.enable = true;

  };
}
