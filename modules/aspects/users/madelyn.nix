{
  lib,
  den,
  programs,
  self,
  ...
}: {
  # user aspect
  den.aspects.madelyn = {
    homeManager = {
      options,
      self',
      ...
    }:
      lib.mkMerge [
        {
          home.homeDirectory = "/home/madelyn";

          programs.git.settings.user = {
            email = "moxiebenavides@proton.me";
            name = "Madeline Benavides";
          };

          xdg.dataFile."wallpapers/rose-pine" = {
            enable = true;
            recursive = true;
            source = "${self'.packages.rose-pine-wallpapers}/share/wallpapers/rose-pine";
          };
        }

        (lib.optionalAttrs (options ? theme) {
          theme = {
            image = "${self'.packages.rose-pine-wallpapers}/share/wallpapers/rose-pine/photography/single-celled/river.jpg";
          };
        })
      ];

    includes = [
      (den.batteries.user-shell "fish")
      den.batteries.primary-user
      programs.btop
      programs.direnv
      programs.fzf
      # my editor
      programs.helix
      programs.helix.languages.webDev
      programs.hyfetch
      programs.ripgrep
      programs.screenlockers.gtklock
      # TODO update starship
      programs.starship
      programs.tealdeer
    ];

    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts = {user, ...}: {
      includes = [den.aspects.secrets];

      nixos = {config, ...}: {
        age.secrets.madelyn-secret.file = "${self}/secrets/madelyn-secret.age";

        users = {
          groups.${user.userName} = {};

          users.${user.userName} = {
            description = "Madelyn R.P. Benavides";

            extraGroups = [
              "input"
            ];

            group = user.userName;
            hashedPasswordFile = config.age.secrets.madelyn-secret.path;

            openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMPsHKCQ0mZQ+pCRlvVYh9MtqSnZJwhyhMktJbz3Axf5 Moxie@MoxieGE.com"
            ];
          };
        };
      };
    };
  };
}
