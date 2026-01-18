let
  hdd = ["nodiscard" "nossd"];
  ssd = ["discard" "ssd"];

  large = ["space_cache=v2"];
in {
  inherit ssd hdd large;
}
