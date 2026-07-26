{
  den,
  programs,
  self,
  ...
}: {
  # user aspect
  den.aspects.madelyn = {
    homeManager = {pkgs, ...}: {
      home = {
        homeDirectory = "/home/madelyn";

        packages = builtins.attrValues {
          inherit
            (pkgs)
            baobab
            # cyanrip
            # element-desktop
            nixos-anywhere
            ;
        };
      };

      programs.git.settings.user = {
        email = "moxiebenavides@proton.me";
        name = "Madeline Benavides";
      };
    };

    includes = [
      den.batteries.primary-user
      (den.batteries.user-shell "fish")

      programs.btop
      programs.direnv
      programs.fzf
      programs.hyfetch

      # my editor
      programs.helix
      programs.helix.languages.webDev

      programs.ripgrep
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
