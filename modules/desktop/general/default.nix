{ extra ? null, hardware ? null, lib, ... }: {
    services.flatpak.enable = true;
    services.flatpak.packages = [
        "org.kde.filelight"
        "com.github.tchx84.Flatseal"
    ]
    ++ lib.optionals ((extra.fullDesktop or false) == true) [
        # Media
        "org.videolan.VLC"
        "org.musicbrainz.Picard"
        # Creation
        "org.gimp.GIMP"
        "org.kde.krita"
        "org.kde.kdenlive"
        "org.blender.Blender"
        "org.inkscape.Inkscape"
        "org.audacityteam.Audacity"
        # Utilities
        "app.freelens.Freelens"
    ]
    ++ lib.optionals ((hardware.gaming or false) == true) [
        # Games
        "at.vintagestory.VintageStory"
    ];
    imports = []
        ++ lib.optionals ((extra.fullDesktop or false) == true) [
            ./discord.nix
            ./vivaldi.nix
            ./vscode.nix
        ]
        ++ lib.optionals ((hardware.hypervisor or false) == true) [
            ./virt-manager.nix
        ]
    ;
}