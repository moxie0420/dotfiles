{
  lib,
  pkgs,
  autoPatchelfHook,
  copyDesktopItems,
  fetchFromGitHub,
  libpulseaudio,
  makeDesktopItem,
  makeWrapper,
  nodejs,
  pipewire,
  pnpm_9,
  stdenv,
  electron ? pkgs.electron_33,
}:
stdenv.mkDerivation rec {
  ELECTRON_SKIP_BINARY_DOWNLOAD = "1";

  buildInputs = [
    libpulseaudio
    pipewire
    (lib.getLib stdenv.cc.cc)
  ];

  buildPhase = ''
    runHook preBuild
    pnpm run build

    npm exec electron-builder -- \
      --dir \
      -c.electronDist="${electron.dist}" \
      -c.electronVersion="${electron.version}"

    runHook postBuild
  '';

  desktopItems = [
    (makeDesktopItem {
      categories = ["Network"];
      desktopName = "Legcord";
      exec = "legcord %U";
      icon = "legcord";
      name = "legcord";
      startupWMClass = "Legcord";
      terminal = false;
    })
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/lib/legcord"
    cp -r ./dist/*-unpacked/{locales,resources{,.pak}} "$out/share/lib/legcord"

    install -Dm644 "build/icon.png" "$out/share/icons/hicolor/256x256/apps/legcord.png"

    makeShellWrapper "${lib.getExe electron}" "$out/bin/legcord" \
      --add-flags "$out/share/lib/legcord/resources/app.asar" \
      "''${gappsWrapperArgs[@]}" \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}" \
      --set-default ELECTRON_IS_DEV 0 \
      --inherit-argv0

    runHook postInstall
  '';

  nativeBuildInputs = [
    pnpm_9.configHook
    nodejs
    makeWrapper
    copyDesktopItems
    autoPatchelfHook
  ];

  pname = "legcord";

  pnpmDeps = pnpm_9.fetchDeps {
    inherit pname version src;
    fetcherVersion = 1;
    hash = "sha256-UivO0e50zGNV69AaV4RilmJ9L6L6lctUrUh9CVIOry4=";
  };

  src = fetchFromGitHub {
    hash = "sha256-0RbLvRCvy58HlOhHLcAoErRFgYxjWrKFQ6DPJD50c5Q=";
    owner = "Legcord";
    repo = "legcord";
    rev = "v${version}";
  };

  version = "1.1.1";
}
