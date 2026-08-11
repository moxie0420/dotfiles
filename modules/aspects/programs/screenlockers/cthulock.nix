{programs, ...}: {
  flake-file.inputs.cthulock = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:FriederHannenheim/cthulock";
  };

  programs.screenlockers.cthulock = {
    homeManager = {
      inputs',
      self',
      ...
    }: {
      home.packages = [inputs'.cthulock.packages.default];

      xdg.configFile."cthulock/style.slint".text = ''
        import { LineEdit } from "std-widgets.slint";

        export component HelloWorld inherits Window {
            in property<string> clock_text;
            in property<bool> checking_password;
            in-out property<string> password <=> password.text;
            callback submit <=> password.accepted;
            forward-focus: password;
            states [
                checking when checking-password : {
                    password.enabled: false;
                }
            ]

            Image {
                width: parent.width;
                height: parent.height;
                source: @image-url("${self'.packages.rose-pine-wallpapers}/share/wallpapers/rose-pine/photography/single-celled/river.jpg");
                HorizontalLayout {
                    VerticalLayout {
                        alignment: end;
                        spacing: 10px;
                        padding: 40px;
                        width: 350px;
                        Text {
                            text: clock_text;
                            horizontal-alignment: center;
                            font-size: 60pt;
                            color: white;
                        }
                        password := LineEdit {
                            enabled: true;
                            horizontal-alignment: left;
                            input-type: InputType.password;
                            placeholder-text: "password...";
                        }
                    }
                }
            }
        }
      '';
    };

    nixos = {inputs', ...}: {
      environment.systemPackages = [inputs'.cthulock.packages.default];
      security.pam.services."cthulock" = {};
    };

    provides = {
      to-hosts.includes = [programs.screenlockers.cthulock];
      to-users.includes = [programs.screenlockers.cthulock];
    };
  };
}
