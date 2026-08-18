{
  inputs,
  programs,
  services,
  ...
}: {
  flake-file.inputs.stasis = {
    url = "github:saltnpepper97/stasis";
  };

  services.stasis = {
    homeManager = {
      imports = [
        inputs.stasis.homeModules.default
      ];

      services.stasis = {
        enable = true;

        extraConfig = ''
          lock_after        300
          screen_off_after  300
          suspend_after     1800
          debounce_seconds  4
          notify_seconds    5

          default:
            enable_loginctl_integration true
            enable_dbus_inhibit true
            pre_suspend_command "gtklock -d"
            # prepare_sleep_command "gtklock"
            monitor_media true
            ignore_remote_media true  # ignore remote players (spotify/kdeconnect/etc.)

            # Optional: ignore these media sources for media inhibit (case-insensitive)
            #media_blacklist ["spotify"]

            debounce_seconds debounce_seconds

            # Lid actions (laptop only — live here so they apply to both ac: and battery:)
            lid_close_action "gtklock -d"
            #lid_open_action ""

            # Notify when resuming from IPC pause (e.g. `stasis pause 1h`)
            notify_on_unpause true

            # Enables per-step notifications (only if the block sets `notification`)
            notify_before_action true

            # Icon name/path for Stasis-generated notifications. Defaults to "stasis".
            # Set to "" to disable the default icon, or override per step with
            # notification_icon.
            notification_icon "stasis"

            inhibit_apps [
              r"steam_app_.*"
            ]

            # ----------------------------------------------------------------
            # DESKTOP PLAN (used only on desktop chassis)
            # ----------------------------------------------------------------
            lock_screen:
              timeout lock_after
              command "gtklock -d"
              resume_command "notify-send 'Welcome back $env.USER!'"
              notification "Locking session in 10s"
              notification_icon "dialog-warning"
              notify_seconds_before 10
            end

            # ----------------------------------------------------------------
            # LAPTOP PLANS (used only on laptop chassis — ac: or battery:)
            # Desktop plan blocks above are ignored for laptops.
            # ----------------------------------------------------------------
            ac:
              # timeout 0 runs immediately when AC becomes active
              custom_brightness_instant:
                timeout 0
                command "brightnessctl set 100%"
              end

              brightness:
                timeout 120
                command "brightnessctl set 30%"
              end

              lock_screen:
                timeout 120
                command "gtklock"
                notification "Locking on AC in 10s"
                notify_seconds_before 10
              end

              suspend:
                timeout 300
                command "systemctl suspend"
              end
            end

            battery:
              custom_brightness_instant:
                timeout 0
                command "brightnessctl set 40%"
              end

              brightness:
                timeout 60
                command "brightnessctl set 20%"
              end

              lock_screen:
                timeout 120
                command "gtklock"
                resume_command "notify-send 'Welcome back $env.USER!'"
              end

              suspend:
                timeout 120
                command "systemctl suspend"
              end
            end
          end

          # --------------------------------------------------------------------
          # PROFILES
          #
          # mode "overlay": merges on top of the active base (default/ac/battery)
          # mode "fresh":   starts from nothing — define every global and action block you want
          # --------------------------------------------------------------------

          # gaming: overlay — only replace inhibit_apps
          gaming:
            mode "overlay"

            inhibit_apps [
              r".*\.exe"
              r"steam_app_.*"
              r".*\.x86_64"
            ]
          end

          # work: overlay — longer timeouts, login1 sleep/wake monitoring enabled
          work:
            mode "overlay"

            enable_loginctl_integration true
            enable_dbus_inhibit true
            debounce_seconds 10
            monitor_media true
            ignore_remote_media true

            lock_screen:
              timeout 600
              command "gtklock"
              resume_command "notify-send 'Welcome back, $env.USER!'"
            end

            suspend:
              timeout 3600
              command "systemctl suspend"
            end
          end

          # presentation: fresh — keep display on, suppress all idle actions
          presentation:
            mode "fresh"

            pre_suspend_command None
            enable_dbus_inhibit true
            monitor_media false
            ignore_remote_media true
            debounce_seconds 0
            notify_on_unpause false
            notify_before_action false
            inhibit_apps [ ]

            lid_close_action ""
            lid_open_action ""

            brightness:
              timeout 0
              command "brightnessctl set 100%"
            end
          end
        '';
      };
    };

    includes = [
      programs.screenlockers.gtklock
    ];

    provides.to-users.includes = [services.stasis];
  };
}
