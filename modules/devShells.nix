# Exposes flake devshells
{
  perSystem = {pkgs, ...}: {
    devShells = {
      default =
        pkgs.mkShell {
        };
    };
  };
}
