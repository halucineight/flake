{ pkgs, ... }:
{

  environment.systemPackages = [
    pkgs.sniffnet
  ];

  security.wrappers.sniffnet = {
    source = "${pkgs.sniffnet}/bin/sniffnet";
    owner = "root";
    group = "root";
    capabilities = "cap_net_raw,cap_net_admin+eip";
  };
}
