{ config, pkgs, lib, ... }:
{
    hardware.bluetooth = {
        enable = true; # enables support for Bluetooth
        powerOnBoot = true; # powers up the default Bluetooth controller on boot
    };

    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        jack.enable = false;
        systemWide = true;
    };

    environment.etc =  {
	    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		    bluez_monitor.properties = {
			    ["bluez5.enable-sbc-xq"] = true,
			    ["bluez5.enable-msbc"] = true,
			    ["bluez5.enable-hw-volume"] = true,
			    ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		    }
	    '';
        "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
            context.properties = {
                default.clock.rate = 48000
                default.clock.quantum = 32
                default.clock.min-quantum = 32
                default.clock.max-quantum = 32
            }
        '';
    };

    services = {
        minidlna = {
            enable = true;
            openFirewall = true;
            settings = {
                inotify = "yes";
                media_dir = [
                    "A,/data/Music"
                ];
            };
        };
        mpd = {
            enable = true;
            musicDirectory = "/data/Music";
            startWhenNeeded = true;
        };
        ympd.enable = false;
    };
}