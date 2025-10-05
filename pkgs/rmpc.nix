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
    rev = "4e33a58ebb44660053b2e6f393daefea33a856dc";
    hash = "sha256-4G60bfFuMrWDXGqafGIqci/jSd0Wk7/7bjpwS71JTiU=";
  };

  cargoHash = "sha256-d2/4q2s/11HNE18D8d8Y2yWidhT+XsUS4J9ahnxToI0=";

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
