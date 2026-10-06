{ user, ... }: {
    programs.git = {
        enable = true;
        settings = {
            pull.rebase = false;
            #commit.gpgSign = true;
            init.defaultBranch = "main";
            user.name = user.gecos;
            user.email = user.email;
        };
    };
}