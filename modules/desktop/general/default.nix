{ extra ? {}, hardware ? {}, lib, ... }: {
    imports = []
        ++ lib.optional ((extra.fullDesktop or false) == true) [
            ./discord.nix
            ./vivaldi.nix
            ./vscode.nix
        ]
        ++ lib.optional ((hardware.hypervisor or false) == true) [
            ./virt-manager.nix
        ]
    ;
}