{pkgs, ...}: {
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
        fontconfig

        nerd-fonts.caskaydia-cove
        nerd-fonts.jetbrains-mono

        noto-fonts
        noto-fonts-color-emoji
        noto-fonts-cjk-sans
    ];
}