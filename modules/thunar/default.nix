{ pkgs, ... }:
{
  programs.thunar.enable = true;
  programs.xfconf.enable = true;

  services.tumbler.enable = true;
  services.gvfs.enable = true;

  environment.pathsToLink = [
    "share/thumbnailers"
  ];

  environment.systemPackages = with pkgs; [
    gdk-pixbuf
    ffmpeg-headless
    ffmpegthumbnailer
    webp-pixbuf-loader
    libheif.bin
    libheif.out
    libjxl
  ];
}
