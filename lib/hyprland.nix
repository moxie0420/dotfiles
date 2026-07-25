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
  mkContent = mkProp "content";
  mkFloat = mkProp "float";
  mkFocus = mkProp "focus";
  mkFullscreen = mkProp "fullscreen";
  mkFullscreenStateClient = mkProp "fullscreen_state_client";
  mkFullscreenStateInternal = mkProp "fullscreen_state_internal";
  mkGroup = mkProp "group";
  mkInitialClass = mkProp "initial_class";
  mkInitialTitle = mkProp "initial_title";
  mkModal = mkProp "modal";
  mkPin = mkProp "pin";
  mkTag = mkProp "tag";
  mkTitle = mkProp "title";
  mkWindowRule = {
    effects,
    name,
    props,
  }: let
    effectStrings = forEach (attrsToList effects) (
      e:
        if e.value != null
        then "${e.name} = ${toString e.value}"
        else "${e.name}"
    );
    propStrings = map (p: "match:${p.type} = ${p.pattern}") (flatten props);
  in ''
    windowrule {
      name = ${name}
      ${toLines propStrings}
      ${toLines effectStrings}
    }
  '';
  mkWorkspace = mkProp "workspace";
  mkXdgTag = mkProp "xdg_tag";
  mkXwayland = mkProp "xwayland";
}
