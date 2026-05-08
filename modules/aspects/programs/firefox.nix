{lib, ...}: {
  programs.firefox = let
    sharedPolicies = {
      # Updates are done via Nix.
      AppAutoUpdate = false;
      DisableAppUpdate = true;
      ManualUpdateOnly = true;

      # Disable unwanted or unneeded Firefox features.
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisablePrivateBrowsing = true; # Incognito mode is a separate profile instead.
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      DisablePasswordReveal = true;

      BlockAboutConfig = false;
      BlockAboutProfiles = true;
      BlockAboutSupport = false;

      # Tabs
      OverrideFirstRunPage = "about:newtab";
      OverridePostUpdatePage = "about:newtab";

      # Security
      HttpsOnlyMode = "force_enabled";
      PasswordManagerEnabled = false;
      OfferToSaveLogins = false;
      PrimaryPassword = false;
      DisableMasterPasswordCreation = true;

      # UI and Behavior
      DisplayMenuBar = "never";
      HardwareAcceleration = false;

      ExtensionSettings = extensions;
      "3rdparty".Extensions = extensionConfig;
    };

    # Extions to install
    extensions = let
      moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
    in {
      "uBlock0@raymondhill.net" = {
        install_url = moz "ublock-origin";
        installation_mode = "force_installed";
        updates_disabled = true;
      };

      "FirefoxColor@mozilla.com" = {
        install_url = moz "firefox_color";
        installation_mode = "force_installed";
        updates_disabled = true;
      };

      "{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
        install_url = moz "noscript";
        installation_mode = "force_installed";
        updates_disabled = true;
      };

      "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/file/4749958/bitwarden_password_manager-2026.3.0.xpi";
        installation_mode = "force_installed";
        updates_disabled = true;
      };
    };

    # settings for installed extensions
    extensionConfig = {
      "uBlock0@raymondhill.net".adminSettings = {
        userSettings = {
          uiTheme = "dark";
          uiAccentCustom = true;
          uiAccentCustom0 = "#8300ff";
          cloudStorageEnabled = lib.mkForce false;
        };

        selectedFilterLists = [
          "adguard-generic"
          "adguard-annoyance"
          "adguard-social"
          "adguard-spyware-url"
          "easylist"
          "easyprivacy"
          "plowe-0"
          "ublock-abuse"
          "ublock-badware"
          "ublock-filters"
          "ublock-privacy"
          "ublock-quick-fixes"
          "ublock-unbreak"
          "urlhaus-1"
        ];
      };
    };
  in {
    nixos.programs.firefox = {
      enable = true;

      policies = lib.mkMerge [
        sharedPolicies
      ];
    };

    homeManager = {
      config,
      pkgs,
      ...
    }: {
      programs.firefox = {
        enable = true;

        configPath = "${config.xdg.configHome}/mozilla/firefox";

        policies = lib.mkMerge [
          sharedPolicies
        ];

        profiles = {
          default = {
            extensions.force = true;
            search = {
              force = true;
              default = "ddg";
              privateDefault = "ddg";

              engines = {
                "Nix Packages" = {
                  urls = [
                    {
                      template = "https://search.nixos.org/packages";
                      params = [
                        {
                          name = "channel";
                          value = "unstable";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = ["@np"];
                };

                "Nix Options" = {
                  urls = [
                    {
                      template = "https://search.nixos.org/options";
                      params = [
                        {
                          name = "channel";
                          value = "unstable";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = ["@no"];
                };

                "NixOS Wiki" = {
                  urls = [
                    {
                      template = "https://wiki.nixos.org/w/index.php";
                      params = [
                        {
                          name = "search";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = ["@nw"];
                };
              };
            };
          };
        };
      };
    };
  };
}
