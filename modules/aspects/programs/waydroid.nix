{
  programs.waydroid = {
    nixos = {pkgs, ...}: {
      # Enable clipboard sharing
      environment.systemPackages = [pkgs.wl-clipboard];

      virtualisation = {
        waydroid = {
          enable = true;
          # Newer kernel versions may need
          package = pkgs.waydroid-nftables;
        };
      };
    };
  };
}
