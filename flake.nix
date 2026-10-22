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

        baseModule = { ... }: {
            programs.home-manager.enable = true;
            imports = [
                ./modules/shell
                ./modules/desktop
            ];
        };

        userModules = {
            elliana = { imports = [ ./modules/elliana ]; };
        };

        mkShellHome = {
            username, 
            modules ? [],
            system ? "x86_64-linux",
            homeDirectory ? "/home/${username}",
        }: home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
            modules = [
                baseModule
                {
                    home.stateVersion = "26.05";
                    home.username = username;
                    home.homeDirectory = homeDirectory;
                    targets.genericLinux.enable = true;
                }
            ] ++ modules;
        };
    in {
        homeModules = {
            default = baseModule;
        } // userModules;
        homeConfigurations = nixpkgs.lib.genAttrs 
            [ "elliana" "ellianap" "ellianapadmin" ] 
            (username: mkShellHome { inherit username; modules = [ userModules.elliana ]; });
    };
}