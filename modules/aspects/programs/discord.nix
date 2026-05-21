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
          enableReactDevtools = true;

          enabledThemes = [];

          frameless = true;

          plugins = {
            ClearURLs.enable = true;
            CopyUserURLs.enable = true;
            CustomRPC.enable = true;
            MutualGroupDMs.enable = true;

            richPresence.enable = true;
            userMessagesPronouns.enable = true;

            # OnePingPerDM is an equicord only option
            OnePingPerDM = {
              enable = true;
              allowMentions = true;
            };

            PinDMs = {
              enable = true;
              canCollapseDmSection = true;
            };

            # ReviewDB is an eqicord only option
            ReviewDB.enable = true;

            USRBG.enable = true;
            alwaysAnimate.enable = true;
          };
        };
      };
    };
  };
}
