{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set tabstop=4
      set softtabstop=0 noexpandtab
      set shiftwidth=4
    '';
    plugins = with pkgs.vimPlugins; [
      vim-pandoc
      vim-pandoc-syntax
    ];
  };
}
