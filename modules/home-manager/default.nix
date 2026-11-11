{
  lib,
  dotfiles,
  gruvshell,
  gruvboxTmux,
  ...
}:

let
  mkHomeUser = name: {
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
      inherit dotfiles gruvshell gruvboxTmux;
    };

    users = lib.genAttrs [ "halucineight" "playground" ] mkHomeUser;
  };
}
