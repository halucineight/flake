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
    let
      system = "x86_64-linux";
      overlays = (import ./overlays/default.nix).nixpkgs.overlays;
      pkgs = import nixpkgs {
        inherit system;
        inherit overlays;
      };
      localConfig =
        if builtins.pathExists ./local.nix then
          import ./local.nix {
            config = { };
            lib = nixpkgs.lib;
            inherit pkgs;
          }
        else
          { };
      enableElixirDevShell = localConfig.modules.enableElixirDevShell or false;
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              self
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
          inherit system;
          specialArgs = {
            inherit
              self
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

      devShells.${system} =
        { }
        // nixpkgs.lib.optionalAttrs enableElixirDevShell {
          elixir = pkgs.mkShell {
            packages = with pkgs; [
              elixir
              erlang
	      tailwindcss_4
	      esbuild
              rebar3
	      inotify-tools
	      pgcli
            ];
          };
        };
      };

}
