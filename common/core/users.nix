{pkgs, ...}: {
  users.users.moxie = {
    description = "Moxie P. Benavides";
    extraGroups = [
      "adbusers"
      "docker"
      "plugdev"
      "audio"
      "video"
      "wheel"
      "pipewire"
      "cdrom"
      "mpd"
      "seat"
    ];
    isNormalUser = true;
    shell = pkgs.fish;
    home = "/home/moxie";
  };
}
