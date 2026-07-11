{
  config,
  lib,
  dotfiles,
  gruvshell,
  ...
}:

let
  mkHomeUser =
    user:
    lib.nameValuePair user.name {
      imports = [
        ./common.nix
        ./gtk.nix
      ];

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings."*".AddKeysToAgent = "yes";
      };
    };
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit dotfiles gruvshell;
    };

    users = builtins.listToAttrs (map mkHomeUser config.users.list);
  };
}
