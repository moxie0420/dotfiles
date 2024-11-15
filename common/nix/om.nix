{
  inputs,
  pkgs,
  ...
}: {
  environment.defaultPackages = [inputs.omnix.packages.${pkgs.system}.default];
}
