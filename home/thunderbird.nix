{...}: {
  programs.thunderbird = {
    enable = true;

    profiles = {
      moxie = {
        isDefault = true;
        withExternalGnupg = true;
      };
    };
  };
}
