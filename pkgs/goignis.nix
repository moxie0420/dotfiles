{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule (final: {
  checkFlags = let
    # Skip tests that require network access
    skippedTests = [
      "ExampleDBusCall"
      "ExampleDBusCallIgnis"
    ];
  in ["-skip=^${builtins.concatStringsSep "$|^" skippedTests}$"];

  pname = "goignis";

  src = fetchFromGitHub {
    hash = "sha256-PGdCQ74OCiyO7qkhz6wauxJ52GnuLmKQaDY+T8itF8I=";
    owner = "ignis-sh";
    repo = "goignis";
    rev = "v${final.version}";
  };

  vendorHash = "sha256-y3B3qFpxnnBe2HhO5u0sXYPOKJ0+akBEiN6oCSDETXM=";
  version = "0.1.0";

  meta = {
    description = "An optional, high-performance CLI for the Ignis widget framework ";
    homepage = "https://github.com/ignis-sh/goignis";
    license = lib.licenses.mit;
  };
})
