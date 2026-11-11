{ pkgs, ... }:

{
  services.udev.packages = [ pkgs.openocd ];
  users.groups = {
    plugdev = { };
    shared = { };
  };
}
