{
  lib,
  self,
  withSystem,
  ...
}: let
  description = ''
    Provides `lib'` as a top level argument.

    ## Usage

    **Global (Recommended):**
    Apply to all hosts, users, and homes.

    den.default.includes = [ system.lib' ];

    **Specific:**
    Apply only to a specific host, user, or home aspect.

    den.aspects.my-laptop.includes = [ system.lib'];
    den.aspects.alice.includes = [ system.lib' ];
  '';
  hmAspect = {home}:
    {
      name = "lib'/home";
    }
    // lib.optionalAttrs (home ? class) (mkAspect home.class);
  mkAspect = class: {
    ${class}._module.args.lib' = self.lib;
  };
  osAspect = {host}:
    {
      name = "lib'/os";
    }
    // lib.optionalAttrs (host ? class) (mkAspect host.class);
  userAspect = {user}: {
    includes = map (c: mkAspect c) user.classes;
    name = "lib'/user";
  };
in {
  system.lib' = {
    inherit description;

    includes = [
      osAspect
      userAspect
      hmAspect
    ];

    name = "lib'";
  };
}
