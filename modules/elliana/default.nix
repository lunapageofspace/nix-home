{ lib, pkgs, user, ... }:
let
    keysFile = pkgs.writeText "authorized_keys" (lib.concatLines [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILldl7APHiXrjz5+XORRTCvc8FNPWE6qo9T7LjXwinQd openpgp:0xDCB1825D"
    ]);
in {
    programs.git = {
        enable = true;
        settings = {
            user.name = "Elliana Perry";
            user.email = "elliana.perry@gmail.com";
        };
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
    programs.ssh = {
        enable =true;
        settings = {
            "*" = {
                AddKeysToAgent = "no";
                ForwardAgent = false;
                Compression = true;
                ServerAliveInterval = 15;
                ServerAliveCountMax = 3;
                HashKnownHosts = false;
                UserKnownHostsFile = "~/.ssh/known_hosts";
                ControlMaster = "no";
                ControlPath = "~/.ssh/master-%r@%n:%p";
                ControlPersist = "no";
                TCPKeepAlive = "yes";
                PKCS11Provider = "${pkgs.yubico-piv-tool}/lib/libykcs11.so";
            };
            "hecate.zynthovian.xyz" = { ForwardAgent = true; };
            "apollon.zynthovian.xyz" = { ForwardAgent = true; };
        };
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