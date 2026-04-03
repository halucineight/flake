{ config
, lib
, ags
, dotfiles
, ags-shell
, ...
}:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      osConfig = config;
      inherit ags dotfiles ags-shell;
    };

    users.${config.users.primaryUser} = {
      imports = [
        ./common.nix
        ./gtk.nix
      ];

      # User-specific settings
      home.username = config.users.primaryUser;
      home.homeDirectory = "/home/${config.users.primaryUser}";

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = {
          "*" = {
            addKeysToAgent = "yes";
          };
        };
      };

    };

    users.playground = lib.mkIf config.users.createPlaygroundUser {
      imports = [ ./common.nix ];

      home.username = "playground";
      home.homeDirectory = "/home/playground";

    };
  };

}
