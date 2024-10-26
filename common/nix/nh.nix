{
  programs.nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d";
    };
    flake = "/home/moxie/dotfiles";
  };
}
