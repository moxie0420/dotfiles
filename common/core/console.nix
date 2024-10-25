{pkgs, ...}: {
  console = {
    earlySetup = true;
    packages = with pkgs; [gpm gpm-ncurses];
  };
}
