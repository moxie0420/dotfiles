{services, ...}: {
  services.swayidle = {
    homeManager = {
      services.swayidle = {
        enable = true;

        events = [
          {
            # adding duplicated entries for the same event may not work
            command = (display "off") + "; " + lock;
            event = "before-sleep";
          }
          {
            command = display "on";
            event = "after-resume";
          }
          {
            command = (display "off") + "; " + lock;
            event = "lock";
          }
          {
            command = display "on";
            event = "unlock";
          }
        ];
      };
    };

    provides.to-users.includes = [services.swayidle];
  };
}
