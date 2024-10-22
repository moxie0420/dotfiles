{lib, ...}: {
  catppuccin = {
    enable = true;
    accent = "pink";
    flavor = "mocha";
    pointerCursor.enable = lib.mkForce false;
  };
  qt.style.catppuccin = {
    enable = true;
    accent = "pink";
    flavor = "mocha";
  };
}
