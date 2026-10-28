{ pkgs, ... }: {
    programs.vscode = {
        enable = true;
        profiles.default = {
            enableUpdateCheck = false; # It is annoying
            userSettings = {
                "chat.disableAIFeatures" = true;
                "cSpell.enabled" = false;
                "dotfiles.repository" = "https://github.com/TkPegatron/dotfiles.git";
                "dotfiles.installCommand" = "install.sh";
                "editor.renderWhitespace" = "all";
                "editor.fontFamily" = "'CaskaydiaCove Nerd Font Mono','Droid Sans Mono', 'monospace', monospace";
                "editor.fontLigatures" = true;
                "workbench.colorTheme" = "Catppuccin Mocha";
                "workbench.iconTheme" = "catppuccin-mocha";
                "git.confirmSync" = false;
                "terminal.integrated.enableMultiLinePasteWarning" = false;
            };
            extensions = with pkgs.vscode-extensions; [
                bbenoist.nix
                aaron-bond.better-comments
                oderwat.indent-rainbow
                catppuccin.catppuccin-vsc
                catppuccin.catppuccin-vsc-icons
                davidanson.vscode-markdownlint
                bierner.markdown-checkbox
                bierner.markdown-emoji
                # Need to ovveride the version for at least remote-containers
                #ms-vscode-remote.remote-ssh
                #ms-vscode-remote.remote-containers
            ];
        };
    };
}