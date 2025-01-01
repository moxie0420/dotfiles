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
    ];
    isNormalUser = true;
    shell = pkgs.nushell;
  };
}
