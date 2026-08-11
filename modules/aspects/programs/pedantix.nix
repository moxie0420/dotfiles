{inputs, ...}: let
  settings = {
    args = {
      first = ["lib" "stdenv" "fetchurl" "fetchFromGitHub" "fetchFromGitLab"];
      last = ["<defaulted>" "..."];
    };

    attrs = {
      blank-lines = 1;
      blank-lines-mode = "multiline";

      first = [
        "pname"
        "version"
        "src"
        "outputs"
        "__structuredAttrs"
        "strictDeps"
        "patches"
        "postPatch"
        "nativeBuildInputs"
        "buildInputs"
        "propagatedBuildInputs"
        "cargoLock"
        "cargoHash"
        "vendorHash"
        "npmDepsHash"
        "configureFlags"
        "cmakeFlags"
        "mesonFlags"
        "makeFlags"
        "buildFlags"
        "env"
        "preConfigure"
        "postConfigure"
        "preBuild"
        "buildPhase"
        "postBuild"
        "doCheck"
        "nativeCheckInputs"
        "checkInputs"
        "checkFlags"
        "preCheck"
        "checkPhase"
        "postCheck"
        "preInstall"
        "installPhase"
        "postInstall"
        "doInstallCheck"
        "nativeInstallCheckInputs"
        "installCheckPhase"
        "preFixup"
        "postFixup"
      ];

      last = ["passthru" "meta"];
      merge = true;
      sort = true;
    };

    formatter = "alejandra";
    lets.sort = true;

    overrides = [
      # Sort environment.systemPackages
      {
        lists.sort = true;
        path = "**.environment.systemPackages";
      }
      # Sort home.ackages
      {
        lists.sort = true;
        path = "**.home.packages";
      }
      # Restore one blank line between the inputs of a flake.nix
      {
        attrs.blank-lines = 1;
        path = "inputs";
      }
      # sort aspect includes
      {
        lists.sort = true;
        path = "**.den.aspects.*.includes";
      }

      {
        attrs.first = [
          "url"
          "owner"
          "repo"
          "rev"
          "tag"
          "hash"
          "sha256"
          "fetchSubmodules"
        ];

        path = "**.src";
      }

      {
        attrs.first = [
          "description"
          "longDescription"
          "homepage"
          "changelog"
          "license"
          "sourceProvenance"
          "maintainers"
          "platforms"
          "badPlatforms"
          "mainProgram"
        ];

        path = "**.meta";
      }
    ];

    preset = "nixos-module";
    top-level-blank-lines = 1;
  };
in {
  flake-file.formatter = pkgs: inputs.pedantix.packages.${pkgs.stdenv.hostPlatform.system}.pedantix-wrapped;

  perSystem.treefmt = {
    programs.pedantix = {
      inherit settings;
      enable = true;
    };
  };

  programs.pedantix = {
    homeManager = {
      imports = [
        inputs.pedantix.homeModules.default
      ];

      programs.pedantix = {
        inherit settings;
        enable = true;
      };
    };
  };
}
