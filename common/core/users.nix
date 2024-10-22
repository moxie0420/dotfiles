{pkgs, ...}: {
  users.users.moxie = {
    isNormalUser = true;
    shell = pkgs.nushell;
    extraGroups = [
      "adbusers"
      "docker"
      "plugdev"
      "video"
      "wheel"
      "wireshark"
    ];
  };
}
