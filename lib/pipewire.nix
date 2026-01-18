{lib, ...}: {
  getDeviceChannel = channel: {
    "audio.position" = lib.flatten channel;
  };

  mkCaptureProps = {
    device,
    name ? "Input",
    extraConfig ? {},
  }: {
    "capture.props" =
      {
        "node.name" = name;
        "target.object" = device;
      }
      // extraConfig;
  };

  mkPlaybackProps = {
    device,
    name ? "Input",
    extraConfig ? {},
  }: {
    "playback.props" =
      {
        "node.name" = name;
        "media.class" = "Audio/Source";
        "target.object" = device;
      }
      // extraConfig;
  };

  mkNode = {
    name,
    description ? "",
    extraConfig,
  }: {
    name = "libpipewire-module-loopback";
    args =
      {
        "node.name" = name;
        "node.description" = description;
      }
      // extraConfig;
  };
}
