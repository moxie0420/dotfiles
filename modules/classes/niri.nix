{
  classes,
  den,
  ...
}: {
  classes.niri = den.policies.niri-to-programs-niri-settings;

  den.policies.niri-to-programs-niri-settings = _: [
    (den.lib.policy.route {
      fromClass = "niri";
      intoClass = "homeManager";
      path = ["programs" "niri" "settings"];
    })
  ];

  den.schema.homeMaanager.includes = [classes.niri];
}
