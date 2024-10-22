{pkgs, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Moxie Benavides";
    userEmail = "moxie@moxiege.com";
    extraConfig = {
      safe = {
        directory = "*";
      };
      init = {
        defaultBranch = "master";
      };
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };
  };
}
