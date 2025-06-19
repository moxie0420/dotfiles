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
      "wireshark"
      "pipewire"
      "cdrom"
      "mpd"
    ];
    isNormalUser = true;
    shell = pkgs.nushell;
    home = "/home/moxie";
  };
}
