_: {
    programs.git = {
        enable = true;
        extraConfig = {
            pull.rebase = false;
            #commit.gpgSign = true;
            init.defaultBranch = "main";
            user.name = "Elliana Perry";
            user.email = "elliana.perry@gmail.com";
        };
    };
}