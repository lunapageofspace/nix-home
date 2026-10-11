{ lib, pkgs, user, ... }:
let
    keysFile = pkgs.writeText "authorized_keys" (lib.concatLines [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKJM4tUWj387mgpedyOnJLKsNvm29FSeXxawheAY3szq openpgp:yk-22730621"
    ]);
in {
    programs.git = {
        enable = true;
        settings = {
            user.name = "Elliana Perry";
            user.email = "elliana.perry@gmail.com";
        };
    };
    programs.ssh = {
        enable =true;
        extraConfig = ''
            PKCS11Provider "${pkgs.yubico-piv-tool}/lib/libykcs11.so"
        '';
    };
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
            "7E526BF08BDE22EAB03F7540B35EBA69910F6A4E"
        ];
    };
    home.packages = [ pkgs.yubico-piv-tool ];
    home.activation.authorizedKeys = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run install -d -m 700 "$HOME/.ssh"
        run install -m 600 ${keysFile} "$HOME/.ssh/authorized_keys"
        if [ -x /usr/sbin/restorecon ]; then
        run /usr/sbin/restorecon -R "$HOME/.ssh"
        fi
    '';
}