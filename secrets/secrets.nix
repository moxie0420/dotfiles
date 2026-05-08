let
  nixUwU = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILTeVZscLiUUaoHUt1gREI57weXBWeTK7ZZpc73h+nQn";

  systems = [nixUwU];

  files = [
    "authentik.age"
    "authentik-ldap.age"
    "qbittorrent.age"
    "homarr.age"
    "radarr-key.age"
    "sonarr-key.age"
    "tailscale-auth-env.age"
    "traefik.age"
  ];

  # from nixpkgs
  nameValuePair = name: value: {inherit name value;};
  genAttrs' = xs: f: builtins.listToAttrs (map f xs);
  genAttrs = names: f: genAttrs' names (n: nameValuePair n (f n));
in
  genAttrs files (name: {
    publicKeys = systems;
  })
