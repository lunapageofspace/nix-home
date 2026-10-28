{ extra ? null, hardware ? null, lib, ... }: {
    services.flatpak.enable = true;
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