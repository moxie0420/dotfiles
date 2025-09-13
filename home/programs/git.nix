{pkgs, ...}: {
  home.packages = with pkgs; [
    github-desktop
    gh
  ];

  programs = {
    git = {
      enable = true;
      userName = "Moxie Benavides";
      userEmail = "moxie@moxiege.com";
      extraConfig = {
        safe = {
          directory = "*";
        };
        init = {
          defaultBranch = "master";
        };
        credential.helper = "store";
      };
    };
    lazygit.enable = true;
    gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };
  };
}
