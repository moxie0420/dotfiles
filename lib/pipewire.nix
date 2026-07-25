{lib, ...}: {
  getDeviceChannel = channel: {
    "audio.position" = lib.flatten channel;
  };
  mkCaptureProps = {
    device,
    extraConfig ? {},
    name ? "Input",
  }: {
    "capture.props" =
      {
        "node.name" = name;
        "target.object" = device;
      }
      // extraConfig;
  };
  mkNode = {
    extraConfig,
    name,
    description ? "",
  }: {
    args =
      {
        "node.description" = description;
        "node.name" = name;
      }
      // extraConfig;
    name = "libpipewire-module-loopback";
  };
  mkPlaybackProps = {
    device,
    extraConfig ? {},
    name ? "Input",
  }: {
    "playback.props" =
      {
        "media.class" = "Audio/Source";
        "node.name" = name;
        "target.object" = device;
      }
      // extraConfig;
  };
}
