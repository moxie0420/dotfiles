{pkgs, ...}: {
  imports = [
    ./lorri.nix
    ./nh.nix
    ./nixpkgs.nix
    ./substituters.nix
  ];

  environment.systemPackages = [pkgs.git];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;

    age = {
      sshKeyPaths = ["/home/moxie/.ssh/bitbucket_personal"];
      keyFile = "/home/moxie/.config/sops/age/keys.txt";
      generateKey = true;
    };

    secrets = {
      "lastfm-password" = {};
    };
  };

  nix = {
    package = pkgs.lix;
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];

      keep-derivations = true;
      keep-outputs = true;

      trusted-users = ["root" "@wheel"];
    };
  };
}
