_: {
    programs.zellij = {
        enable = true;
        enableZshIntegration = true;
        attachExistingSession = true;
        settings = {
            default_mode = "locked";
        };
    };
}