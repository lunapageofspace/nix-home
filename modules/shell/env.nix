{ config, ... }: {
    xdg.enable = true;
    xdg.userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = true;
        desktop = "${config.home.homeDirectory}/.desktop";
        documents = "${config.home.homeDirectory}/Documents";
        pictures = "${config.home.homeDirectory}/Pictures";
        videos = "${config.home.homeDirectory}/Videos";
        music = "${config.home.homeDirectory}/Music";
    };
    home.sessionPath = [
        "${config.home.homeDirectory}/.local/bin"
    ];
}