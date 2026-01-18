{
  lib,
  lib',
  ...
}: {
  boot = {
    blacklistedKernelModules = [
      "intel_pmc_bxt"
      "intel_oc_wdt"
      "iTCO_wdt"
    ];
    initrd.supportedFilesystems.btrfs = true;
    initrd.luks.devices = {
      "nixroot-A" = {
        device = "/dev/disk/by-uuid/f83f89a2-d3ee-41fe-baa2-158dfffae084";
        allowDiscards = true;
      };
      "nixroot-B" = {
        device = "/dev/disk/by-uuid/c0f9aa2e-12ca-4ed4-8e7d-ffc4e6a53af1";
        allowDiscards = true;
      };
    };

    kernelParams = [
      "nowatchdog"
      "mitigations=off"
    ];

    supportedFilesystems = {
      btrfs = true;
      f2fs = true;
      vfat = true;
    };
  };

  containers = {
    jellyfin = {
      autoStart = true;
      config = ../containers/jellyfin.nix;
    };
  };

  environment.variables.__GL_VRR_ALLOWED = 1;

  fileSystems = let
    inherit (lib'.disks) defaults btrfs;
  in {
    "/" = {
      device = "/dev/disk/by-label/NixUwU";
      options = defaults ["subvol=root" btrfs.ssd];
    };
    "/home" = {
      device = "/dev/disk/by-label/NixUwU";
      options = defaults ["subvol=home" btrfs.ssd];
    };
    "/nix" = {
      device = "/dev/disk/by-label/NixUwU";
      options = defaults ["subvol=nix" btrfs.ssd];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/DE88-5AAD";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077" "defaults"];
    };
    "/home/moxie/Music" = {
      device = "/dev/disk/by-uuid/bc5ec750-0252-4151-9c43-1a9a23e92803";
      options = defaults ["subvol=music" btrfs.hdd btrfs.large];
      depends = ["/mnt/the_store"];
    };
    "/mnt/the_store" = {
      device = "/dev/disk/by-uuid/bc5ec750-0252-4151-9c43-1a9a23e92803";
      options = defaults ["users" "nofail" "exec" btrfs.hdd];
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    keyboard.qmk.enable = true;
  };

  moxie.graphics.nvidia.enable = true;

  networking.hostName = "nixUwU";

  nix.settings.system-features = ["gccarch-x86-64-v3"];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  powerManagement.cpuFreqGovernor = "performance";

  programs.gamemode.settings = {
    general = {
      softrealtime = "auto";
      renice = 10;
    };

    gpu = {
      apply_gpu_optimisations = "accept-responsibility";
      gpu_device = 0;
      nv_powermizer_mode = 1;

      nv_core_clock_mhz_offset = 200;
      nv_mem_clock_mhz_offset = 200;
    };
  };

  services = {
    caddy = {
      enable = true;
      virtualHosts = {
        "https://nixuwu.tail83fd33.ts.net".extraConfig = ''
          encode zstd gzip

          handle /vault/* {
            reverse_proxy localhost:8812 {
              header_up X-Real-IP {remote_host}
            }
          }

          handle /admin/* {
            reverse_proxy localhost:8080 {
              transport http {
                tls_insecure_skip_verify
              }
            }
          }

          handle /* {
            reverse_proxy localhost:11000
          }
        '';

        "https://nixuwu.tail83fd33.ts.net:3000".extraConfig = ''
          reverse_proxy localhost:8096
        '';
      };
    };

    cloudflared = {
      enable = true;
      certificateFile = "/home/moxie/.cloudflared/cert.pem";
      tunnels = {
        "cbb9a353-f866-4edd-8a21-a07b318bcc43" = {
          credentialsFile = "/home/moxie/.cloudflared/cbb9a353-f866-4edd-8a21-a07b318bcc43.json";
          default = "http_status:404";
          ingress = {
            "matrix.moxiege.com" = "http://localhost:8008";
          };
        };
      };
    };

    hardware.openrgb.motherboard = "intel";
    pipewire = {
      extraConfig.pipewire = {
        "91-split-stereo-input" = {
          "context.modules" = let
            inherit (lib) mkMerge;
            inherit (lib'.pipewire) getDeviceChannel mkCaptureProps mkNode mkPlaybackProps;
            uac2 = "alsa_input.usb-ZOOM_Corporation_UAC-2_000000000000000000000000200641D4-00.pro-input-0";

            captureConf = {
              "stream.dont-remix" = true;
              "node.passive" = true;
              "node.dont-reconnect" = true;
            };

            playbackConf = {
              "node.passive" = true;
              "node.dont-reconnect" = true;
            };
          in [
            (mkNode rec {
              name = "UAC2 Input 1";
              description = name;
              extraConfig = mkMerge [
                (mkCaptureProps {
                  device = uac2;
                  name = "Mic";
                  extraConfig = mkMerge [
                    (getDeviceChannel "AUX0")
                    captureConf
                  ];
                })

                (mkPlaybackProps {
                  device = uac2;
                  name = "Mic";
                  extraConfig = mkMerge [
                    (getDeviceChannel "MONO")
                    playbackConf
                  ];
                })
              ];
            })
            (mkNode rec {
              name = "UAC2 Input 2";
              description = name;
              extraConfig = mkMerge [
                (mkCaptureProps {
                  device = uac2;
                  name = "Bass";
                  extraConfig = mkMerge [
                    (getDeviceChannel "AUX1")
                    captureConf
                  ];
                })

                (mkPlaybackProps {
                  device = uac2;
                  name = "Bass";
                  extraConfig = mkMerge [
                    (getDeviceChannel "MONO")
                    playbackConf
                  ];
                })
              ];
            })
          ];
        };

        "92-bit-perfect" = {
          "context.properties" = {
            "default.clock.allowed-rates" = [44100 48000 88200 96000];
          };
        };

        "92-low-latency" = {
          "context.properties" = {
            "node.pause-on-idle" = false;
            "channelmix.mix-lfe" = true;

            "default.clock.rate" = 48000;
            "default.clock.quantum" = 256;
            "default.clock.min-quantum" = 256;
            "default.clock.max-quantum" = 256;
          };
        };
      };

      wireplumber.extraConfig = {
        "uac2-pro-audio" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {
                  node.name = "alsa_output.usb-ZOOM_Corporation_UAC-2_000000000000000000000000200641D4-00*";
                }
              ];
              actions.update-props."device.profile" = "pro-audio";
            }
          ];
        };
      };
    };

    tailscale = {
      enable = true;
      permitCertUid = "caddy";
      useRoutingFeatures = "both";
    };
  };
  system.stateVersion = "26.05";

  virtualisation = {
    podman.defaultNetwork.settings.dns_enabled = true;

    oci-containers.containers = {
      "matrix" = {
        image = "matrixdotorg/synapse:latest";
        ports = ["8008:8008"];
        volumes = ["synapse-data:/data"];
        dependsOn = ["postgres"];
        networks = ["internal"];
      };

      # "nextcloud-aio-mastercontainer" = {
      #   image = "ghcr.io/nextcloud-releases/all-in-one:latest";

      #   environment = {
      #     APACHE_PORT = "11000";
      #     APACHE_IP_BINDING = "0.0.0.0";
      #     SKIP_DOMAIN_VALIDATION = "true";
      #   };

      #   extraOptions = ["--sig-proxy=false"];

      #   ports = ["8080:8080"];

      #   volumes = [
      #     "nextcloud_aio_mastercontainer:/mnt/docker-aio-config"
      #     "/var/run/docker.sock:/var/run/docker.sock:ro"
      #   ];
      # };

      "postgres" = {
        image = "postgres:18-alpine";

        environment = {
          POSTGRES_USER = "synapse";
          POSTGRES_DATABASE = "synapse";
          POSTGRES_INITDB_ARGS = "--encoding=UTF-8 --locale=C";
        };
        networks = ["internal"];

        ports = ["5432:5432"];

        volumes = [
          "postgresData:/var/lib/postgresql/data"
          "/var/dendrite:/var/lib/postgresql"
        ];
      };

      "vaultwarden" = {
        image = "vaultwarden/server:latest";

        environment = {
          DOMAIN = "https://nixuwu.tail83fd33.ts.net/vault/";
          SIGNUPS_ALLOWED = "true";
        };

        ports = ["8812:80"];

        volumes = ["vaultwarden:/data"];
      };
    };
  };
}
