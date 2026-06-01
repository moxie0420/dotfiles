{
  den,
  inputs,
  ...
}: {
  flake-file.inputs.nixcord.url = "github:FlameFlag/nixcord";
  programs.discord = {
    includes = [
      (den.provides.unfree ["discord"])
    ];
    homeManager = {
      imports = [
        inputs.nixcord.homeModules.nixcord
      ];

      programs.nixcord = {
        enable = true;
        discord.enable = false;
        equibop.enable = true;

        config = {
          autoUpdate = true;

          enabledThemes = [];

          frameless = true;

          plugins = {
            alwaysAnimate.enable = true;
            betterGifAltText.enable = true;
            betterSettings.enable = true;
            betterUploadButton.enable = true;
            biggerStreamPreview.enable = true;
            ClearURLs.enable = true;
            colorSighted.enable = true;
            copyFileContents.enable = true;
            copyStickerLinks.enable = true;
            CopyUserURLs.enable = true;
            CustomRPC.enable = true;

            fakeNitro.enable = true;
            fixYoutubeEmbeds.enable = true;

            memberCount.enable = true;
            mentionAvatars.enable = true;
            MutualGroupDMs.enable = true;

            noMosaic.enable = true;
            noOnboardingDelay.enable = true;
            noTypingAnimation.enable = true;

            openInApp.enable = true;

            petpet.enable = true;
            PinDMs = {
              enable = true;
              canCollapseDmSection = true;
            };

            roleColorEverywhere.enable = true;

            shikiCodeblocks.enable = true;

            USRBG.enable = true;

            voiceDownload.enable = true;
            voiceMessages.enable = true;
            volumeBooster.enable = true;

            # Equicord only Options
            betterCommands.enable = true;

            declutter.enable = true;

            equibopStreamFixes.enable = true;

            richPresence.enable = true;

            userMessagesPronouns.enable = true;
          };
        };
      };
    };
  };
}
