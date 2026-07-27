{
  inputs,
  programs,
  ...
}: {
  flake-file.inputs.nixcord = {
    inputs = {
      nixpkgs.follows = "nixpkgs";
      nixpkgs-nixcord.follows = "nixpkgs";
    };

    url = "github:FlameFlag/nixcord";
  };

  programs.discord = {
    homeManager = {
      imports = [
        inputs.nixcord.homeModules.nixcord
      ];

      programs.nixcord = {
        config = {
          autoUpdate = true;
          enabledThemes = [];
          frameless = true;

          plugins = {
            alwaysAnimate.enable = true;
            # Equicord only Options
            betterCommands.enable = true;
            betterGifAltText.enable = true;
            betterSettings.enable = true;
            betterUploadButton.enable = true;
            biggerStreamPreview.enable = true;
            clearUrls.enable = true;
            colorSighted.enable = true;
            copyFileContents.enable = true;
            copyStickerLinks.enable = true;
            copyUserUrls.enable = true;
            customRpc.enable = true;
            declutter.enable = true;
            equibopStreamFixes.enable = true;
            fakeNitro.enable = true;
            fixYoutubeEmbeds.enable = true;
            memberCount.enable = true;
            mentionAvatars.enable = true;
            mutualGroupDms.enable = true;
            noMosaic.enable = true;
            noOnboardingDelay.enable = true;
            noTypingAnimation.enable = true;
            openInApp.enable = true;
            petpet.enable = true;

            pinDms = {
              canCollapseDmSection = true;
              enable = true;
            };

            richPresence.enable = true;
            roleColorEverywhere.enable = true;
            shikiCodeblocks.enable = true;
            userMessagesPronouns.enable = true;
            usrbg.enable = true;
            voiceDownload.enable = true;
            voiceMessages.enable = true;
            volumeBooster.enable = true;
          };
        };

        discord.enable = false;
        enable = true;
        equibop.enable = true;
      };
    };

    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.equibop];
    };

    provides = {
      to-hosts.includes = [programs.discord];
      to-users.includes = [programs.discord];
    };
  };
}
