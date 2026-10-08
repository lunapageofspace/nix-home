{
    description = "Home Manager configuration";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = { self, nixpkgs, home-manager, ... }:
    let
        mkShellHome = { user, system ? "x86_64-linux", homeDirectory ? "/home/${user.username}" }: home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
            extraSpecialArgs = { inherit user; };
            modules = [
                ./modules/shell
                {
                    home.stateVersion = "24.05";
                    home.username = user.username;
                    home.homeDirectory = homeDirectory;
                    programs.home-manager.enable = true;
                    targets.genericLinux.enable = true;
                }
            ];
        };
        elliana = {
            username = "elliana";
            gecos = "Elliana Perry";
            email = "elliana.perry@gmail.com";
        };
    in {
        homeConfigurations = nixpkgs.lib.genAttrs 
            [ "elliana" "ellianap" "ellianapadmin" ] 
            (username: mkShellHome {
                user = elliana // { inherit username; };
        });
    };
}