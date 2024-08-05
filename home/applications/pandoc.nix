{pkgs, ...}: {
  home.packages = with pkgs; [
    texliveFull
  ];

  programs.pandoc = {
    enable = true;
    defaults = {
      metadata = {
        author = "Moxie Benavides";
        lang = "en-US";
      };
      pdf-engine = "xelatex";
      citeproc = false;
    };
    citationStyles = [./files/modern-language-association.csl];
  };
}
