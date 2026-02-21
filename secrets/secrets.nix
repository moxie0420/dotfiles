let
  nixUwU = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILTeVZscLiUUaoHUt1gREI57weXBWeTK7ZZpc73h+nQn";

  systems = [nixUwU];
in {
  "authentik.age".publicKeys = systems;
  "authentik-ldap.age".publicKeys = systems;
  "qbittorrent.age".publicKeys = systems;
  "homarr.age".publicKeys = systems;
}
