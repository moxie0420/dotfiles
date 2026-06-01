{
  inputs,
  den,
  ...
}: let
  inherit (inputs.den) namespace;
  inherit (den.lib) __findFile;
in {
  imports = [
    (namespace "desktop" true)
    (namespace "classes" true)
    (namespace "hardware" true)
    (namespace "programs" true)
    (namespace "services" true)
    (namespace "system" true)
  ];

  _module.args.__findFile = __findFile;
}
