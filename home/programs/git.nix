{
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
    };
  };
}
