{ pkgs, ... }: {
  imports = [
    ./bat.nix
    ./direnv.nix
    ./env.nix
    ./git.nix
    ./gpg.nix
    ./lsd.nix
    ./nvim.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    skim fd perl
  ];
}