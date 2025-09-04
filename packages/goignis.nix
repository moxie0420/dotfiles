{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:
buildGoModule (final: {
  pname = "goignis";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "ignis-sh";
    repo = "goignis";
    rev = "v${final.version}";
    hash = "sha256-PGdCQ74OCiyO7qkhz6wauxJ52GnuLmKQaDY+T8itF8I=";
  };

  vendorHash = "sha256-y3B3qFpxnnBe2HhO5u0sXYPOKJ0+akBEiN6oCSDETXM=";

  checkFlags = let
    # Skip tests that require network access
    skippedTests = [
      "ExampleDBusCall"
      "ExampleDBusCallIgnis"
    ];
  in ["-skip=^${builtins.concatStringsSep "$|^" skippedTests}$"];

  meta = {
    description = "An optional, high-performance CLI for the Ignis widget framework ";
    homepage = "https://github.com/ignis-sh/goignis";
    license = lib.licenses.mit;
  };
})
