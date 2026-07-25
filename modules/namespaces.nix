{
  den,
  inputs,
  ...
}: let
  inherit (inputs.den) namespace;
in {
  imports = [
    (namespace "desktop" true)
    (namespace "classes" true)
    (namespace "hardware" true)
    (namespace "programs" true)
    (namespace "services" true)
    (namespace "system" true)
  ];

  _module.args.__findFile = den.lib.__findFile;
}
