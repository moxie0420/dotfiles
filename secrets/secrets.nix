let
  adminUsers = [madelyn];
  files = [
    "authentik.age"
    "authentik-ldap.age"
    "forgejo-admin-secret.age"
    "homarr.age"
    "madelyn-secret.age"
    "qbittorrent.age"
    "radarr-key.age"
    "sonarr-key.age"
    "tailscale-auth-env.age"
    "vaultwarden.age"
    "github.age"
  ];
  genAttrs = names: f: genAttrs' names (n: nameValuePair n (f n));
  genAttrs' = xs: f: builtins.listToAttrs (map f xs);
  madelyn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMPsHKCQ0mZQ+pCRlvVYh9MtqSnZJwhyhMktJbz3Axf5 Moxie@MoxieGE.com";
  # from nixpkgs
  nameValuePair = name: value: {inherit name value;};
  nixOwO = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFjqKdZ5mkDXF2s8Qvtq5VzOIzf9toZgnZrQGhgbUydx";
  nixUwU = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILTeVZscLiUUaoHUt1gREI57weXBWeTK7ZZpc73h+nQn";
  systems = [
    nixUwU
    nixOwO
    theHub
  ];
  theHub = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCC4febKLLf0JLLAAdWLDPyOB8VcytD1W3uCWX8RufV root@theHub";
in
  genAttrs files (name: {
    publicKeys = adminUsers ++ systems;
  })
