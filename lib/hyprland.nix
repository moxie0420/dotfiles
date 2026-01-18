{
  lib,
  toLines,
  ...
}: let
  inherit (lib) flatten forEach attrsToList;

  mkProp = type: pattern: {
    inherit type pattern;
  };
in {
  mkClass = mkProp "class";
  mkTitle = mkProp "title";

  mkInitialClass = mkProp "initial_class";
  mkInitialTitle = mkProp "initial_title";

  mkTag = mkProp "tag";

  mkXwayland = mkProp "xwayland";

  mkFloat = mkProp "float";

  mkFullscreen = mkProp "fullscreen";

  mkPin = mkProp "pin";

  mkFocus = mkProp "focus";

  mkGroup = mkProp "group";

  mkModal = mkProp "modal";

  mkFullscreenStateClient = mkProp "fullscreen_state_client";

  mkFullscreenStateInternal = mkProp "fullscreen_state_internal";

  mkWorkspace = mkProp "workspace";

  mkContent = mkProp "content";

  mkXdgTag = mkProp "xdg_tag";

  mkWindowRule = {
    name,
    props,
    effects,
  }: let
    propStrings = map (p: "match:${p.type} = ${p.pattern}") (flatten props);
    effectStrings = forEach (attrsToList effects) (
      e:
        if e.value != null
        then "${e.name} = ${toString e.value}"
        else "${e.name}"
    );
  in ''
    windowrule {
      name = ${name}
      ${toLines propStrings}
      ${toLines effectStrings}
    }
  '';
}
