{ config
, lib
, dotfiles
, gruvshell
, ...
}:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      osConfig = config;
      inherit dotfiles gruvshell;
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
        settings."*".AddKeysToAgent = "yes";
      };

    };

    users.playground = lib.mkIf config.users.createPlaygroundUser {
      imports = [ 
        ./common.nix
        ./gtk.nix
      ];

      home.username = "playground";
      home.homeDirectory = "/home/playground";

    };
  };

}
