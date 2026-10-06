{ pkgs, ... }: {
    home.packages = with pkgs; [ neovim ];
    programs.git.extraConfig.core.editor = "${pkgs.neovim}/bin/nvim";
    home.sessionVariables = {
        EDITOR = "${pkgs.neovim}/bin/nvim";
        VISUAL = "${pkgs.neovim}/bin/nvim";
    };
    programs.zsh.shellAliases = { 
        nano = "${pkgs.neovim}/bin/nvim";
        vim = "${pkgs.neovim}/bin/nvim";
        vi = "${pkgs.neovim}/bin/nvim";
    };
}