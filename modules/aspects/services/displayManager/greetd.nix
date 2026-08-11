{
  services.displayManager.greetd = {
    nixos = {
      config,
      user,
      ...
    }: {
      services.greetd = {
        enable = true;

        settings = rec {
          default_session = initial_session;

          initial_session = {
            command = "${config.programs.niri.package}/bin/niri-session";
            user = user.name;
          };
        };
      };
    };
  };
}
