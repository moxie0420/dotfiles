{programs, ...}: {
  programs.awww = {
    homeManager = {
      services.awww = {
        enable = true;
        extraArgs = [];
      };
    };

    provides.to-users.includes = [
      programs.awww
    ];
  };
}
