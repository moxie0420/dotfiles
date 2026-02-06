let
  nixUwU = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJVu/938C9fg3any878lzP7IfazRFM5xiVVXEYabdV/c";

  systems = [nixUwU];
in {
  "qbittorrent.age" = {
    publicKeys = systems;
    armor = true;
  };
}
