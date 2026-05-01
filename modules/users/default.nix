{ config, lib, pkgs, ... }:
#TODO: This is kinda clunky, fix later
{
  options = {
    users.primaryUser = lib.mkOption {
      type = lib.types.str;
      description = "Your primary user";
      example = "myusername";
    };

    users.createPlaygroundUser = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to create the playground user account";
    };
  };

  config = {
    users.users.${config.users.primaryUser} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "input"
      ];
      packages = with pkgs; [
        tree
      ];
    };

    #Optional playground user for games and stuff
    users.users.playground = lib.mkIf config.users.createPlaygroundUser {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
      ];
      packages = with pkgs; [
        tree
      ];
    };
  };
}
