let
  ezaAliases = let
    eza = "eza --group-directories-first";
  in {
    l = eza;
    la = "${eza} -a";
    ll = "${eza} -l --time-style=long-iso --header";
    ls = eza;
  };
in {
  system.shell.eza = {
    homeManager = {
      home.shellAliases = ezaAliases;

      programs.eza = {
        colors = "auto";
        enable = true;
        git = true;
        icons = "auto";

        theme = {
          blocks.foreground = "#6e6a86";
          broken_path_overlay.foreground = "#524f67";
          broken_symlink.foreground = "#eb6f92";
          colourful = true;
          control_char.foreground = "#31748f";
          date.foreground = "#31748f";

          file_type = {
            build.foreground = "#6e6a86";
            compiled.foreground = "#31748f";
            compressed.foreground = "#c4a7e7";
            crypto.foreground = "#403d52";
            document.foreground = "#908caa";
            image.foreground = "#f6c177";
            lossless.foreground = "#6e6a86";
            music.foreground = "#9ccfd8";
            source.foreground = "#ebbcba";
            temp.foreground = "#ebbcba";
            video.foreground = "#eb6f92";
          };

          filekinds = {
            block_device.foreground = "#ebbcba";
            char_device.foreground = "#f6c177";
            directory.foreground = "#9ccfd8";
            executable.foreground = "#c4a7e7";
            mount_point.foreground = "#403d52";
            normal.foreground = "#e0def4";
            pipe.foreground = "#908caa";
            socket.foreground = "#21202e";
            special.foreground = "#c4a7e7";
            symlink.foreground = "#524f67";
          };

          flags.foreground = "#c4a7e7";

          git = {
            conflicted.foreground = "#ebbcba";
            deleted.foreground = "#eb6f92";
            ignored.foreground = "#6e6a86";
            modified.foreground = "#f6c177";
            new.foreground = "#9ccfd8";
            renamed.foreground = "#31748f";
            typechange.foreground = "#c4a7e7";
          };

          git_repo = {
            branch_main.foreground = "#908caa";
            branch_other.foreground = "#c4a7e7";
            git_clean.foreground = "#9ccfd8";
            git_dirty.foreground = "#eb6f92";
          };

          header.foreground = "#908caa";
          inode.foreground = "#908caa";

          links = {
            multi_link_file.foreground = "#31748f";
            normal.foreground = "#9ccfd8";
          };

          octal.foreground = "#9ccfd8";

          perms = {
            attribute.foreground = "#908caa";
            group_execute.foreground = "#c4a7e7";
            group_read.foreground = "#908caa";
            group_write.foreground = "#403d52";
            other_execute.foreground = "#c4a7e7";
            other_read.foreground = "#908caa";
            other_write.foreground = "#403d52";
            special_other.foreground = "#403d52";
            special_user_file.foreground = "#c4a7e7";
            user_execute_file.foreground = "#c4a7e7";
            user_execute_other.foreground = "#c4a7e7";
            user_read.foreground = "#908caa";
            user_write.foreground = "#403d52";
          };

          punctuation.foreground = "#524f67";

          security_context = {
            colon.foreground = "#908caa";
            range.foreground = "#c4a7e7";
            role.foreground = "#c4a7e7";
            typ.foreground = "#6e6a86";
            user.foreground = "#9ccfd8";
          };

          size = {
            major.foreground = "#908caa";
            minor.foreground = "#9ccfd8";
            number_byte.foreground = "#908caa";
            number_giga.foreground = "#c4a7e7";
            number_huge.foreground = "#c4a7e7";
            number_kilo.foreground = "#524f67";
            number_mega.foreground = "#31748f";
            unit_byte.foreground = "#908caa";
            unit_giga.foreground = "#c4a7e7";
            unit_huge.foreground = "#9ccfd8";
            unit_kilo.foreground = "#31748f";
            unit_mega.foreground = "#c4a7e7";
          };

          symlink_path.foreground = "#9ccfd8";

          users = {
            group_other.foreground = "#6e6a86";
            group_root.foreground = "#eb6f92";
            group_yours.foreground = "#524f67";
            user_other.foreground = "#c4a7e7";
            user_root.foreground = "#eb6f92";
            user_you.foreground = "#f6c177";
          };
        };
      };
    };

    nixos = {pkgs, ...}: {
      environment = {
        shellAliases = ezaAliases;

        systemPackages = builtins.attrValues {
          inherit (pkgs) eza;
        };
      };
    };
  };
}
