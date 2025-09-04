{pkgs, ...}: {
  home.packages = [pkgs.fastfetch];
  programs.hyfetch = {
    enable = true;
    settings = {
      backend = "fastfetch";
      pride_month_disable = false;
      preset = "transgender";
      mode = "rgb";
      color_align = {
        mode = "horizontal";
      };
    };
  };
}
