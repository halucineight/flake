{
  description = "My multi-machine NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "github:quickshell-mirror/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url = "git+ssh://git@github.com/halucineight/dotfiles.git";
      flake = false;
    };

    gruvshell = {
      url = "git+ssh://git@github.com/halucineight/gruvshell.git";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      quickshell,
      dotfiles,
      gruvshell,
      ...
    }:
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              dotfiles
              gruvshell
              ;
            quickshellFlake = quickshell;
          };
          modules = [
            ./configuration.nix
            ./machines/desktop
            home-manager.nixosModules.home-manager
          ];
        };
        ph315 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              dotfiles
              gruvshell
              ;
            quickshellFlake = quickshell;
          };
          modules = [
            ./configuration.nix
            ./machines/ph315
            home-manager.nixosModules.home-manager
          ];
        };

      };
    };

}
