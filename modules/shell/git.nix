{ user, ... }: {
    programs.git = {
        enable = true;
        settings = {
            pull.rebase = false;
            init.defaultBranch = "main";
        };
    };
}