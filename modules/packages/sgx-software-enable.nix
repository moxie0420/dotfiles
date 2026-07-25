{den, ...}: {
  den.aspects.pkgs.sgx-software-enable = {
    packages = {pkgs, ...}: {
      sgx-software-enable = pkgs.callPackage ../../pkgs/sgx-software-enable.nix {};
    };
  };
  den.schema.flake-system.includes = [
    den.aspects.pkgs.sgx-software-enable
  ];
}
