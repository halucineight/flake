{
  config,
  lib,
  self,
  ...
}:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://cache.nixos-cuda.org"
    ];

    trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };

  nix.registry.myflake.flake = self;

  nix.gc = {
    automatic = true; # enable periodic GC
    dates = "weekly"; # systemd.time(7) format
    options = "--delete-older-than 3d";
  };

  nixpkgs.config.allowUnfree = true;
}
