{ pkgs, ... }: {
    home.packages = with pkgs; [
        virt-manager
    ];
    dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
            autoconnect = [ "qemu:///system" ];
            uris = [ "qemu:///system" "qemu+ssh://elliana@hecate.zynthovian.xyz/system" ];
        };
    };
}