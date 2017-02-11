# Glorious System Configuration Files

This repo keeps all my text based configuration files across systems.
It expects to be cloned into `~/config`.
(Yes that is confusingly like `.config` without the `.`.)

## Nix(OS)

`/etc/nixos/configuration.nix` should be symlinked to `nix/<platform>/configuration.nix`.

## Dotfiles

To install on a new system:

    cd dotfiles
    ../link-dotfiles *

In the future I'll try to make this integrate with Nix similar to how configuration files in `/etc` are generated.

Vim and Fish (and possibly other programs in the future) can optionally read system specific local configurations from a parallel repo stored at `~/config-local`.
(For example, I use this at work to avoid leaking my totally not boring top secret command aliases.)
