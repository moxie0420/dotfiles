{...}: {
  services.gpm = {
    enable = true;
    protocol = "pnp";
  };

  services.kmscon = {
    enable = true;
  };
}
