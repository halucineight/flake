{ pkgs, ... }:

{
  users.users = {
    halucineight = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "input"
        "dialout"
        "plugdev"
      ];
      packages = [ pkgs.tree ];
    };
    playground = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "networkmanager" ];
    };
  };

  users.users.halucineight.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDMxDkbWNsZ5hNx2/aF/cf3RDFLRjLHGr7UaQdchlcH9 playground@ph315"
  ];
  users.users."playground".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDMxDkbWNsZ5hNx2/aF/cf3RDFLRjLHGr7UaQdchlcH9 playground@ph315"
  ];

}
