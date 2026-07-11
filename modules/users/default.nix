{
  config,
  lib,
  pkgs,
  ...
}:

let
  commonGroups = [
    "networkmanager"
    "input"
    "plugdev"
  ];
  primaryExtraGroups = [
    "wheel"
    "video"
    "dialout"
  ];
  userNames = map (u: u.name) config.users.list;
in
{
  options = {
    users.primaryUser = lib.mkOption {
      type = lib.types.str;
      description = "Your primary user";
      example = "myusername";
    };

    users.list = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              default = "";
            };
            extraGroups = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ ];
            };
            packages = lib.mkOption {
              type = lib.types.listOf lib.types.package;
              default = [ ];
            };
          };
        }
      );
      default = [ ];
      description = "List of user accounts to create";
    };
  };

  config = {
    assertions = [
      {
        assertion = builtins.elem config.users.primaryUser userNames;
        message = "users.primaryUser must be present in users.list.";
      }
    ];

    services.udev.packages = [ pkgs.openocd ];
    users.groups.plugdev = { };

    users.users = builtins.listToAttrs (
      map (
        u:
        lib.nameValuePair u.name {
          isNormalUser = true;
          shell = pkgs.zsh;
          extraGroups =
            commonGroups
            ++ u.extraGroups
            ++ (lib.optionals (u.name == config.users.primaryUser) primaryExtraGroups);
          packages = u.packages ++ (lib.optionals (u.name == config.users.primaryUser) [ pkgs.tree ]);
        }
      ) config.users.list
    );
  };
}
