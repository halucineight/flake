{ config, lib, ags, dotfiles, ags-shell, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { osConfig = config; inherit ags dotfiles ags-shell; };

    users.${config.users.primaryUser} = {
      imports = [ ./common.nix ];

      # User-specific settings
      home.username = config.users.primaryUser;
      home.homeDirectory = "/home/${config.users.primaryUser}";
    };

    users.playground = lib.mkIf config.users.createPlaygroundUser {
      imports = [ ./common.nix ];

      home.username = "playground";
      home.homeDirectory = "/home/playground";

    };
  };

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;  
  security.pam.services.sddm.enableGnomeKeyring = true;

  programs.ssh.startAgent = true;
  programs.ssh.agentTimeout = null;
}
