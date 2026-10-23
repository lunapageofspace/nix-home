{ desktop ? null, lib, ... }:
let
    knownDesktops = [ "gnome" "plasma" "hyprland" ]; 
    isGraphical   = desktop != null;
    isKnown       = !isGraphical || builtins.elem desktop knownDesktops;
in
{
    assertions = [{
        assertion = isKnown;
        message   = "Unknown desktop '${desktop}'. Known: ${lib.concatStringsSep ", " knownDesktops}";
    }];
    imports =
        lib.optionals isGraphical [ ./general ]
        ++ lib.optional (desktop == "gnome")    ./gnome
        ++ lib.optional (desktop == "plasma")   ./plasma
        ++ lib.optional (desktop == "hyprland") ./hyprland;
}