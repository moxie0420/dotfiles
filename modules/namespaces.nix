{
  inputs,
  den,
  ...
}: {
  imports = let
    inherit (inputs.den) namespace;
  in [
    (namespace "desktop" true)
    (namespace "programs" true)
    (namespace "services" true)
    (namespace "system" true)
  ];

  _module.args.__findFile = den.lib.__findFile;
}
