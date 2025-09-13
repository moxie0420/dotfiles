{pkgs, ...}: {
  users.users.moxie = {
    description = "Moxie P. Benavides";
    extraGroups = [
      "docker"
      "plugdev"
      "audio"
      "video"
      "wheel"
      "pipewire"
      "cdrom"
      "mpd"
      "seat"
      "input"
    ];
    isNormalUser = true;
    shell = pkgs.fish;
    home = "/home/moxie";
  };
}
