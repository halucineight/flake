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
}
