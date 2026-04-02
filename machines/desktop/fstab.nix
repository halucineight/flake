# /etc/nixos/fstab.nix
{ ... }:
{
  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/46d83e0c-6109-438b-96de-1421fe668f0e";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  fileSystems."/data2" = {
    device = "/dev/disk/by-uuid/87ff5e52-4984-416b-b6a5-f9d1e4cbd67f";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  fileSystems."/data-ssd" = {
    device = "/dev/disk/by-uuid/c1a88a89-3ef5-4f3d-a79f-b7e8bb80a242";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  # Create the directory, but do NOT mount anything automatically.
  systemd.tmpfiles.rules = [
    "d /secret 0700 root root -"
  ];
}

