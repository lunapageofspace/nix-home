# Nix Home-Manager configuration

This repository contains my basic shell configuration.

I decided to detach home-manager from the NixOS system configuration for versatility.

## Prerequisites

Nix with flakes enabled. On non-NixOS hosts with a multi-user install, add this to
`/etc/nix/nix.conf` and restart the daemon:

```ini
experimental-features = nix-command flakes
```

## Bootstrapping

To install this configuration on a given host without a preexisting home-manager configuration installed:

```bash
nix run home-manager/release-26.05 -- switch -b bak --refresh --flake github:lunapageofspace/nix-home#elliana
```

Subsequent updates or switches can then be done using:

```bash
home-manager switch --flake github:lunapageofspace/nix-home
```

Without a `#name`, home-manager picks `$USER@$(hostname)` if it exists, otherwise `$USER`.

## Updating

Updates are made in a local checkout, committed with the lock file, then pulled down on each host.

Update all inputs (nixpkgs, home-manager) to the latest commit on their pinned branches:

```bash
nix flake update
```

Or update a single input:

```bash
nix flake update nixpkgs
```

Build before committing to catch errors, then review what changed:

```bash
nix build .#homeConfigurations.elliana.activationPackage
nix store diff-closures ~/.local/state/nix/profiles/home-manager ./result
```

Then, commit and push the lock file

## Applying updates

On each host:

```bash
home-manager switch --refresh --flake github:lunapageofspace/nix-home
```

`--refresh` is needed shortly after a push; Nix caches what a `github:` ref resolves to for about an hour.

To test uncommitted changes from a local checkout without pushing:

```bash
home-manager switch --flake ~/.nix-home
```

## Rolling back

List previous generations:

```bash
home-manager generations
```

Activate an older one by running its `activate` script, using the store path from the list:

```bash
/nix/store/<hash>-home-manager-generation/activate
```

## Cleanup

Remove generations older than 30 days, then collect garbage:

```bash
home-manager expire-generations "-30 days"
nix-collect-garbage
```

## Upgrading to a new release

When a new NixOS/home-manager release comes out (e.g. 26.11):

1. Change both input URLs in `flake.nix` (`nixos-26.05` and `release-26.05`).
2. Run `nix flake update`, build, commit, and push.
3. Update the bootstrap command above to the new release branch.

Do not change `home.stateVersion`. It records the release a home was first activated with,
not the one it currently runs.

## Use from the NixOS system configuration

The system flake consumes this repository as the `home-config` input. After pushing changes here:

```bash
cd ~/src/NixOS
nix flake update home-config
sudo nixos-rebuild switch --flake .
```

To test local, unpushed changes against a system build:

```bash
sudo nixos-rebuild switch --flake . --override-input home-config path:/home/elliana/src/nix-home
```