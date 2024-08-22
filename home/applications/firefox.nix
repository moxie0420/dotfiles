{...}:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
    profiles = let
      fonts = {
        "font.blacklist.underline-offset" = "";
        "gfx.downloadable-fonts.disable-cache" = true;
        "gfx.font.rendering.graphite.enabled" = false;
        "gfx.font.rendering.opentype.svg.enabled" = false;
      };
    in {
      moxie = {
        settings =
          {
            "browser.link.open_newwindow" = 1;
            "browser.link.open_newwindow.disabled_in_fullscreen" = true;

            "browser.tabs.remote.warmup.enabled" = false;
            "browser.tabs.remote.warmup.maxTabs" = 0;

            "browser.tabs.allowTabDetach" = false;
            "browser.tabs.closeWindowWithLastTab" = false;

            "privacy.userContext.enabled" = true;
            "privacy.userContext.ui.enabled" = true;
            "privacy.userContext.newTabContainerOnLeftClick.enabled" = true;

            "browser.tabs.remote.separatePrivilegedMozillaWebContentProcess" = false;
            "browser.tabs.remote.separatedMozillaDomains" = "";

            "browser.tabs.remote.subframesPreferUsed" = false;
          }
          ++ fonts;
      };
    };
  };
}
f
