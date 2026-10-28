{ ... }: {
    services.flatpak = {
        packages = [ "com.vivaldi.Vivaldi" ];
        overrides."com.vivaldi.Vivaldi".Context = {
            sockets = [ "wayland" "!fallback-x11" "x11" "gpg-agent" "pcsc" ];
        };
    };
}