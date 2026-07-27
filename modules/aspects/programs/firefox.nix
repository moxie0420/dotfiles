{
  lib,
  programs,
  ...
}: {
  programs.firefox = let
    # settings for installed extensions
    extensionConfig = {
      "uBlock0@raymondhill.net".adminSettings = {
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

        userSettings = {
          cloudStorageEnabled = lib.mkForce false;
          uiAccentCustom = true;
          uiAccentCustom0 = "#8300ff";
          uiTheme = "dark";
        };
      };
    };
    # Extions to install
    extensions = let
      moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
    in {
      "FirefoxColor@mozilla.com" = {
        install_url = moz "firefox_color";
        installation_mode = "force_installed";
        updates_disabled = true;
      };

      "uBlock0@raymondhill.net" = {
        install_url = moz "ublock-origin";
        installation_mode = "force_installed";
        updates_disabled = true;
      };

      "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/file/4749958/bitwarden_password_manager-2026.3.0.xpi";
        installation_mode = "force_installed";
        updates_disabled = true;
      };

      "{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
        install_url = moz "noscript";
        installation_mode = "force_installed";
        updates_disabled = true;
      };
    };
    sharedPolicies = {
      "3rdparty".Extensions = extensionConfig;
      # Updates are done via Nix.
      AppAutoUpdate = false;
      BlockAboutConfig = false;
      BlockAboutProfiles = true;
      BlockAboutSupport = false;
      DisableAppUpdate = true;
      # Disable unwanted or unneeded Firefox features.
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisableMasterPasswordCreation = true;
      DisablePasswordReveal = true;
      DisablePocket = true;
      DisablePrivateBrowsing = true; # Incognito mode is a separate profile instead.
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      # UI and Behavior
      DisplayMenuBar = "never";
      DontCheckDefaultBrowser = true;
      ExtensionSettings = extensions;
      HardwareAcceleration = false;
      # Security
      HttpsOnlyMode = "force_enabled";
      ManualUpdateOnly = true;
      OfferToSaveLogins = false;
      # Tabs
      OverrideFirstRunPage = "about:newtab";
      OverridePostUpdatePage = "about:newtab";
      PasswordManagerEnabled = false;
      PrimaryPassword = false;
    };
    sharedPreferences = {
      "extensions.formautofill.addresses.enabled" = false;
      "extensions.formautofill.addresses.supported" = false;
      "extensions.formautofill.available" = "off";
      "extensions.formautofill.creditCards.supported" = false;
    };
  in {
    homeManager = {
      config,
      pkgs,
      ...
    }: {
      programs.firefox = {
        configPath = "${config.xdg.configHome}/mozilla/firefox";
        enable = true;

        policies = lib.mkMerge [
          sharedPolicies
        ];

        profiles = {
          default = {
            extensions.force = true;

            search = {
              default = "ddg";

              engines = {
                "Nix Options" = {
                  definedAliases = ["@no"];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

                  urls = [
                    {
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

                      template = "https://search.nixos.org/options";
                    }
                  ];
                };

                "Nix Packages" = {
                  definedAliases = ["@np"];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

                  urls = [
                    {
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

                      template = "https://search.nixos.org/packages";
                    }
                  ];
                };

                "NixOS Wiki" = {
                  definedAliases = ["@nw"];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

                  urls = [
                    {
                      params = [
                        {
                          name = "search";
                          value = "{searchTerms}";
                        }
                      ];

                      template = "https://wiki.nixos.org/w/index.php";
                    }
                  ];
                };
              };

              force = true;
              privateDefault = "ddg";
            };

            settings = lib.mkMerge [
              sharedPreferences
            ];
          };
        };
      };
    };

    nixos = {config, ...}: {
      programs.firefox = {
        enable = true;

        policies = lib.mkMerge [
          sharedPolicies
        ];

        preferences = let
          ffVersion = config.programs.firefox.package.version;
        in
          lib.mkMerge [
            sharedPreferences
            {
              "gfx.x11-egl.force-enabled" = true;
              "media.ffmpeg.vaapi.enabled" = lib.versionOlder ffVersion "137.0.0";
              "media.hardware-video-decoding.force-enabled" = lib.versionAtLeast ffVersion "137.0.0";
              "media.rdd-ffmpeg.enabled" = lib.versionOlder ffVersion "97.0.0";
              "widget.dmabuf.force-enabled" = true;
            }
          ];
      };
    };

    provides = {
      to-hosts.includes = [programs.firefox];
      to-users.includes = [programs.firefox];
    };
  };
}
