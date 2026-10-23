{
    pkgs,
    inputs,
    pkgs-unstable,
    ...
}: {
    wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        package = pkgs-unstable.hyprland;
    };
    home.packages = [
        pkgs.hypridle
        pkgs.hyprlock
        pkgs.quickshell
        pkgs.hyprsunset
        pkgs.hyprpolkitagent
    ];
}