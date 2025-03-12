{
  pkgs,
  lib,
  fetchFromGitHub,
  stdenv,
  pnpm_9,
  nodejs,
  electron ? pkgs.electron_33,
  makeWrapper,
  copyDesktopItems,
  makeDesktopItem,
  autoPatchelfHook,
  libpulseaudio,
  pipewire,
}:
stdenv.mkDerivation rec {
  pname = "legcord";
  version = "dev";

  src = fetchFromGitHub {
    owner = "Legcord";
    repo = "legcord";
    rev = "1833760c8be5b5fd4a76bbcd0cf1632d7bff0216";
    hash = "sha256-LzhkYx1EEJFme9d+hV2BRrZS+gAxt+lKryTfCdUk31Q=";
  };

  buildInputs = [
    libpulseaudio
    pipewire
    (lib.getLib stdenv.cc.cc)
  ];

  nativeBuildInputs = [
    pnpm_9.configHook
    nodejs
    makeWrapper
    copyDesktopItems
    autoPatchelfHook
  ];

  pnpmDeps = pnpm_9.fetchDeps {
    inherit pname version src;
    hash = "sha256-LbHYY97HsNF9cBQzAfFw+A/tLf27y3he9Bbw9H3RKK4=";
  };

  ELECTRON_SKIP_BINARY_DOWNLOAD = "1";

  buildPhase = ''
    runHook preBuild
    pnpm run build

    npx tsx scripts/copyVenmic.mts

    npm exec electron-builder -- \
      --dir \
      -c.electronDist="${electron.dist}" \
      -c.electronVersion="${electron.version}"

    runHook postBuild
  '';

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

  desktopItems = [
    (makeDesktopItem {
      name = "legcord";
      desktopName = "Legcord";
      exec = "legcord %U";
      icon = "legcord";
      categories = ["Network"];
      startupWMClass = "Legcord";
      terminal = false;
    })
  ];
}
