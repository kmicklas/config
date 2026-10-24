update:
    #!/usr/bin/env bash
    set -euo pipefail
    was_clean=$(jj log -r @ --no-graph -T 'empty')
    nix flake update
    nh os switch .
    nh home switch .
    if [[ "$was_clean" == true && $(jj log -r @ --no-graph -T 'empty') == false ]]; then
        jj commit -m "deps: update"
    fi

regen-hardware-config:
    # Hide envfs mounts from nixos-generate-config without affecting the host namespace.
    sudo unshare --mount --propagation private sh -c 'umount /bin && umount /usr/bin && exec nixos-generate-config --show-hardware-config' > hosts/$(hostname)/hardware-configuration.nix.tmp
    mv hosts/$(hostname)/hardware-configuration.nix.tmp hosts/$(hostname)/hardware-configuration.nix
