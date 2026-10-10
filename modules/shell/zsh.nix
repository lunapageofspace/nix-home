{ config, lib, pkgs, ... }:
let
    sudoAlias = "sudo env PATH=$PATH "; # Preserve PATH and aliases
    sudoAliases = {
        sodu  = sudoAlias;
        sodo  = sudoAlias;
        sdoo  = sudoAlias;
        sudu  = sudoAlias;
        sduo  = sudoAlias;
        sudo  = sudoAlias;
    };
    generalAliases = {
        llo   = "${pkgs.lsd}/bin/lsd --long --permission octal";   # Show octal permissions
        cat   = "bat -Pp";                                  # Use bat instead of cat
        ip    = "ip --color=auto";                          # Color IP command
        mkdir = "mkdir -pv";                                # Always create directory trees
    };
in {
    xdg.configFile = {
        "starship.toml".text = builtins.readFile ./config/starship.toml;
    };
    programs.starship.enable = true;
    programs.zsh = {
        enable = true;
        autocd = true;
        dotDir = "${config.xdg.configHome}/zsh";

        envExtra = ''
            ZSH_SELF_LSPWD=true
            WORDCHARS=""
        '';

        history = {
            path = "${config.xdg.dataHome}/zsh/history";
            size = 50000;
            save = 50000;
            extended = false;
            ignoreSpace = true;
            ignoreDups = true;
            share = true;
        };

        initContent = lib.concatMapStrings builtins.readFile [
            ./config/zshrc
        ];

        shellAliases = generalAliases // sudoAliases;

        plugins = [
            {
                name = "F-Sy-H";
                src = builtins.fetchGit {
                    url = "https://github.com/z-shell/F-Sy-H";
                    rev = "7998c36ad2ff1c72babd9b79172ac9f75f56da1a";
                    # tag =  v1.67.1
                };
            }
            {
                name = "zsh-history-substring-search";
                src = builtins.fetchGit {
                    url = "https://github.com/zsh-users/zsh-history-substring-search";
                    rev = "400e58a87f72ecec14f783fbd29bc6be4ff1641c";
                    # tag = v1.1.0
                };
            }
            {
                name = "zsh-completions";
                src = builtins.fetchGit {
                    url = "https://github.com/zsh-users/zsh-completions";
                    rev = "28c5bdcaf81bb89e56d0df8267d822c3b8aed9e0";
                    # tag = 0.36.0
                };
            }
            {
                name = "zsh-autosuggestions";
                src = builtins.fetchGit {
                    url = "https://github.com/zsh-users/zsh-autosuggestions";
                    rev = "e52ee8ca55bcc56a17c828767a3f98f22a68d4eb";
                    # tag = v0.7.1
                };
            }
            {
                name = "skim";
                file = "skim.plugin.zsh";
                src = builtins.fetchGit {
                    url = "https://github.com/casonadams/skim.zsh";
                    rev = "994a8bbc82c1c12fbb20ba0964dbd7a0cacc3b1e";
                };
            }
        ];
    };

}