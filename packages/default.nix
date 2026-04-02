{ config
, pkgs
, lib
, ...
}:

{
  config = {
    environment.systemPackages =
      let
        mandatory = import ./mandatory.nix { inherit pkgs; };
      in
      mandatory;
  };
}
