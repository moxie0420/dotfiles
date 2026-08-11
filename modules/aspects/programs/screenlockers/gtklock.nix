{
  programs.screenlockers.gtklock = {
    nixos = {
      pkgs,
      self',
      ...
    }: {
      programs.gtklock = {
        config.main = {
          idle-hide = true;
          idle-timeout = 15;
        };

        enable = true;

        modules = with pkgs; [
          gtklock-playerctl-module
          gtklock-powerbar-module
          gtklock-userinfo-module
        ];

        style = ''
          window {
             background-image: url("${self'.packages.rose-pine-wallpapers}/share/wallpapers/rose-pine/photography/single-celled/river.jpg");
             background-size: cover;
             background-repeat: no-repeat;
             background-position: center;
             background-color: black;
          }
        '';
      };
    };
  };
}
