{...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "uwsm start default";
        user = "moxie";
      };
      initial_session = {
        command = "uwsm start default";
        user = "moxie";
      };
    };
  };

  security.pam.services.greetd.enableGnomeKeyring = true;
}
