{ user, ... }: {
    programs.git = {
        enable = true;
        lfs.enable = true;
        settings = {
            pull.rebase = false;
            init.defaultBranch = "main";
            safe.directory = "/etc/nixos";
            core.excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
        };
    };
    home.packages = with pkgs; [
        git-xet
    ];
}