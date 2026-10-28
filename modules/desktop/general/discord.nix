{ ... }: {
    services.flatpak.packages = [ "com.discordapp.Discord" ];
    # home.packages = with pkgs; [
    #     (vivaldi.override{ proprietaryCodecs = true; enableWidevine = true; })
    # ];
}