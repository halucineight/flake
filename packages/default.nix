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
        mandatory = import ./mandatory.nix { inherit pkgs quickshellFlake; };
        optional = import ./optional.nix { inherit config lib pkgs; };
      in
      mandatory ++ optional;
  };
}
