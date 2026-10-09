{ lib, pkgs, user, ... }:
let
    keysFile = pkgs.writeText "authorized_keys" (lib.concatLines [
        "ssh-ed25519 AAAA... elliana@hecate"
    ]);
in {
    programs.gpg = {
        enable = true;
        publicKeys = [{
            text = builtins.readFile ./elliana.pgp.pub.asc;
            trust = "ultimate";
        }];
    };
    services.gpg-agent = {
        enable = true;
        sshKeys = [
            "6266C7D74348C35047F78F4B24C6C5D909DCE0E4"
        ];
    };
    programs.git = {
        enable = true;
        settings = {
            user.name = "Elliana Perry";
            user.email = "elliana.perry@gmail.com";
        };
    };
    home.activation.authorizedKeys = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run install -d -m 700 "$HOME/.ssh"
        run install -m 600 ${keysFile} "$HOME/.ssh/authorized_keys"
        if [ -x /usr/sbin/restorecon ]; then
        run /usr/sbin/restorecon -R "$HOME/.ssh"
        fi
    '';
}