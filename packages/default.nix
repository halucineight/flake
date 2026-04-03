{ config
, pkgs
, lib
, quickshellFlake
, ...
}:

{
  config = {
    environment.systemPackages =
      let
        mandatory = import ./mandatory.nix { inherit pkgs quickshellFlake;};
      in
      mandatory;
  };
}
