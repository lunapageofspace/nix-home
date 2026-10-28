{ pkgs, ... }: {
    home.packages = [ pkgs.pinentry-qt ];
    services.gpg-agent.pinentry.package = pkgs.pinentry-qt;
}
