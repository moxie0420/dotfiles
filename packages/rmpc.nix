{
  rustPlatform,
  fetchFromGitHub,
  installShellFiles,
  pkg-config,
  cmake,
}:
rustPlatform.buildRustPackage rec {
  pname = "rmpc";
  version = "6b90b0a3e90ef01cd56f17d854d43e3eea4050cd";

  src = fetchFromGitHub {
    owner = "mierak";
    repo = "rmpc";
    rev = "6b90b0a3e90ef01cd56f17d854d43e3eea4050cd";
    hash = "sha256-TtQwJQVag1FGYwQCmAq478RHO0hcW2S1Pp0ckegdmmg=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-xXH/MRQgT/Je/aOCZ26vdC3PtlosXLIrjbOHtnvf9os=";

  checkFlags = [
    # Test currently broken, needs to be removed. See https://github.com/mierak/rmpc/issues/254
    "--skip=core::scheduler::tests::interleaves_repeated_and_scheduled_jobs"
  ];

  nativeBuildInputs = [
    installShellFiles
    pkg-config
    cmake
  ];

  env.VERGEN_GIT_DESCRIBE = version;

  postInstall = ''
    installManPage target/man/rmpc.1

    installShellCompletion --cmd rmpc \
      --bash target/completions/rmpc.bash \
      --fish target/completions/rmpc.fish \
      --zsh target/completions/_rmpc
  '';
}
