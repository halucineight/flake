{
  description = "My multi-machine NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.astal.follows = "astal";
    };

    dotfiles = {
      url = "git+ssh://git@github.com/halucineight/dotfiles.git";
      flake = false;
    };

    ags-shell = {
      url = "git+ssh://git@github.com/halucineight/ags-shell.git";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ags
    , dotfiles
    , ags-shell
    , ...
    }:
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit ags dotfiles ags-shell; };
          modules = [
            ./configuration.nix
            ./machines/desktop
            home-manager.nixosModules.home-manager
          ];
        };
      };
    };

}
