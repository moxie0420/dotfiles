{
  # Spotify track sync with other devices
  networking.firewall = {
    allowedTCPPorts = [57621];
    allowedUDPPorts = [5353];
  };
}
