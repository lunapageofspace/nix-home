{ lib, pkgs, user, ... }:
let
    keysFile = pkgs.writeText "authorized_keys" (lib.concatLines [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8u8SQls2xm80xrDKGufi9mfrngmjLiapsRnMh1QITi openpgp:0x15554F9B"
        #"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQClBXSdJA/My0Tycrck6vJuPmfVic1IJ66fckdAmF6OPdoLedBF18XZvn/n6vZQejwKOw+8/Ih8YjGqsn3yDVlDUIlJtQC3AsDoHeWPJ4hoNmq6HIslLF2c6le5kecW+NpBdmef8hIuow/TugdpHwL3eiv2Oapl3JVzMHKQgToKianrWjh4Yki7El3wP1FigfHiR3aKud+T72sMB5wgEO4bJ7vUBad0Bk+6dbZgx02iVgnifm23R9dJNtm2ari/SaM61qOCmdRq0wIre+DaFZ29vCHO4V6LxKrFU9Ywd9k/wz2FQU2y/Qjj3QEOUzb9tfTUrbcqI33U2yP7NDbQXfAsKpbWKOCcx7z8p1FRaD+hGYt4aJlcO2DoIPjwjN2jzRAJtRPaKBErzsg6m6+oQ9Cq24g6ccJnh+CvsNbkwyC3bsNtjIvmVUrsJnvXTEc9ev4VoSitUAfqpmBBH73dNA6xLdXogUU/8Y9+3w0IaRYsMNYrM6BFpyQH3aW55i5dVTD5tmVAB2okqk+lE1moSzXoXv8dh2G1qxPHyOWxcf+w22d7F5ROG2f/ykobx21Z6B8PxmUGTp1+YCG8et3sk4QMErz0FRuPeQEM73EpfJAalJ+0rkivUp0XvUUfxDc7VO72F8JXW5yDhwzj6cRviOtsg2RgCK0JYBKEKc2VU7kfyQ== openpgp:0x218CF612"
        #"ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBNiyroVO4PiMV8iQBv2ER0Qb/RdsX5k3OmAtaH4pIhyLcXHe8MdzYdMmnKJKHCBH24cXUQPX1Hm8uq1afxt3yYIVJyzcXXef/3xz2Y0uSpXZrBoJmNqbtCtD8pAL2Oq5Gw=="
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
            "ED2EDC2C8563ABB9404C5877DB56182523676CD1"
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