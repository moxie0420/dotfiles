{
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "dotnet-runtime-6.0.36"
      "dotnet-sdk-wrapped-6.0.428"
      "dotnet-sdk-6.0.428"
    ];
  };
}
