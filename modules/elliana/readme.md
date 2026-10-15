Updating PGP keys and SSH-GPG Agent:

When PGP keys are rotated on my yubikey, The public keys for my ring and the public key for the authentication subkey on my ring needs to be updated here.

1. After completing key rotation, copy the exported public ring to `elliana.pgp.pub.asc`.
1. Using `gpg --list-keys --with-keygrip` locate the the authentication subkey.
1. Add the authentication subkey's keygrip to `services.gpg-agent.sshKeys`.
1. Select the authentication subkey's identifier and run `gpg --export-ssh-key ${IDENTIFIER}!`.
1. Copy the resulting public ssh key into the `keysFile` variable.
