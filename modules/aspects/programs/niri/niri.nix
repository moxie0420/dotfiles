{
  desktop,
  inputs,
  ...
}: {
  desktop.niri = {
    homeManager = {
      imports = [inputs.niri-nix.homeModules.default];
      wayland.windowManager.niri.enable = true;
    };

    # module dpendencies
    includes = [
      desktop.audio
      desktop.dconf
      desktop.keyring
      desktop.launcher
      desktop.notifications
      desktop.polkit
      desktop.wayland
      desktop.xdg

      desktop.niri.binds
      desktop.niri.general
      desktop.niri.input
      desktop.niri.layout
      desktop.niri.outputs
      desktop.niri.windowRules
    ];

    nixos = {pkgs, ...}: {
      environment = {
        pathsToLink = [
          "/share/xdg-desktop-portal"
          "/share/applications"
        ];

        systemPackages = [
          pkgs.xwayland-satellite
        ];
      };

      imports = [inputs.niri-nix.nixosModules.default];
      # Enable Niri
      programs.niri.enable = true;
    };

    provides = {
      to-hosts.includes = [desktop.niri];
      to-users.includes = [desktop.niri];
    };
  };

  flake-file.inputs.niri-nix = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "git+https://codeberg.org/BANanaD3V/niri-nix";
  };
}
