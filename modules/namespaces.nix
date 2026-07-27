{
  den,
  inputs,
  ...
}: let
  inherit (inputs.den) namespace;
in {
  _module.args.__findFile = den.lib.__findFile;

  imports = [
    (namespace "desktop" true)
    (namespace "classes" true)
    (namespace "hardware" true)
    (namespace "programs" true)
    (namespace "services" true)
    (namespace "system" true)
  ];
}
