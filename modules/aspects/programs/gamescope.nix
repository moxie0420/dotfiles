{programs, ...}: {
  programs.gamescope = {
    nixos.programs.gamescope = {
      enable = true;

      args = [
        "--rt"
        "-W 1920"
        "-H 1080"
        "-b"
        "-f"
      ];

      enableWsi = true;
    };

    provides.to-hosts.includes = [
      programs.gamescope
    ];
  };
}
