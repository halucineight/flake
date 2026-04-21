{ config
, lib
, pkgs
, self
, ...
}:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.registry.myflake.flake = self;

  nix.gc = {
    automatic = true; # enable periodic GC
    dates = "weekly"; # systemd.time(7) format
    options = "--delete-older-than 3d";
  };
  
  nixpkgs.config.allowUnfree = true;
}
