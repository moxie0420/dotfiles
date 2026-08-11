# based on https://wiki.archlinux.org/title/Silent_boot
{lib, ...}: {
  system.boot.silent = {
    nixos = {
      boot = {
        consoleLogLevel = lib.mkForce 3;
        initrd.verbose = lib.mkForce false;

        kernelParams = lib.mkBefore [
          "fbcon=nodefer" # Wipes the vendor logo earlier
          "vt.global_cursor_default=0" # Stops cursor blinking while booting
          "quiet" # Less log messages
          "systemd.show_status=auto" # Only show systemd errors
          "udev.log_level=3" # Only show udev errors
          "plymouth.use-simpledrm" # Faster plymouth splash
          "splash" # Show splash
        ];
      };

      environment.etc.issue = {
        mode = "0444";
        # Turns the cursor back on in the TTY
        # It's the output of this commmand
        # setterm -cursor on
        text = "[?12l[?25h";
      };
    };
  };
}
