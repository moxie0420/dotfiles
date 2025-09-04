{
  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "eza";
    };

    interactiveShellInit = ''
      set fish_greeting
    '';
  };
}
