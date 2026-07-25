{programs, ...}: {
  programs.nautilus = {
    nixos = {pkgs, ...}: {
      environment = {
        pathsToLink = ["share/thumbnailers"];
        systemPackages = builtins.attrValues {
          # Nautilus itself
          inherit (pkgs) nautilus;

          # file roller for nautilus' archive management
          inherit (pkgs) file-roller;

          # ffmpeg for video thumbnails
          inherit
            (pkgs)
            ffmpeg-headless
            ffmpegthumbnailer
            ;

          # image thumbnails including avif & jpeg xl
          ## gdk-pixbuf for most image formats
          inherit
            (pkgs)
            gdk-pixbuf
            webp-pixbuf-loader
            ;

          ## libheif for heif support
          inherit
            (pkgs.libheif)
            bin
            out
            ;

          ## libavif & libjxl for avif and jpegxl
          inherit
            (pkgs)
            libavif
            libjxl
            ;
        };
      };

      services.gvfs.enable = true;
    };
    provides = {
      to-hosts.includes = [programs.nautilus];
      to-users.includes = [programs.nautilus];
    };
  };
}
