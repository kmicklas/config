regen-hardware-config:
    # Hide envfs mounts from nixos-generate-config without affecting the host namespace.
    sudo unshare --mount --propagation private sh -c 'umount /bin && umount /usr/bin && exec nixos-generate-config --show-hardware-config' > hosts/$(hostname)/hardware-configuration.nix.tmp
    mv hosts/$(hostname)/hardware-configuration.nix.tmp hosts/$(hostname)/hardware-configuration.nix
