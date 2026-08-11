{
  system.locale = {
    nixos = {pkgs, ...}: {
      i18n = {
        defaultLocale = "en_US.UTF-8";

        inputMethod = {
          enable = true;

          ibus.engines = with pkgs.ibus-engines; [
            # Your engines here
            uniemoji
          ];

          type = "ibus";
        };
      };
    };
  };
}
