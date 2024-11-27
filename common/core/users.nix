{pkgs, ...}: {
  users.users.moxie = {
    description = "Moxie P. Benavides";
    extraGroups = [
      "adbusers"
      "docker"
      "plugdev"
      "video"
      "wheel"
      "wireshark"
    ];
    isNormalUser = true;
    shell = pkgs.nushell;
  };
}
