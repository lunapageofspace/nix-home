{ pkgs, config, ... }: let
    configs = {
        hypr = "hypr";
        waybar = "waybar";
    };
in {
    imports = [
        ./hyprland.nix
        ./fonts.nix
        ./gtk.nix
        ./qt.nix
        ./cursor.nix
    ];
    home.packages = with pkgs; [ kitty ];
    xdg.configFile = (builtins.mapAttrs ( name: subpath: {
        source = ./config/${subpath};
        recursive = true;
    }) configs );
}