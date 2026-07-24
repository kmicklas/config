{ config, pkgs, ... }:

let
  # Double default ZFS trim minimum extent size
  trimMinSize = 64 * 1024 * 1024;
  # `zpool iostat -w` shows a max trim latency of 268ms, with most well below
  # that, so 4 operations per second should hopefully preserve responsiveness.
  trimRate = 4 * trimMinSize;
in {
  imports = [
    ./hardware-configuration.nix

    ../../system/common
    ../../system/efi-boot.nix
    ../../system/graphical.nix
    ../../system/kmicklas.nix
    ../../system/libinput.nix
    ./mdns.nix
  ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/b05d8c49-05f8-4428-bfa5-8243b8a4792c";
      allowDiscards = true;
    };
  };

  # Keep these in sync with hardware-configuration.nix
  fileSystems."/".options = [ "noatime" ];
  fileSystems."/nix".options = [ "noatime" ];
  fileSystems."/home".options = [ "noatime" ];
  fileSystems."/boot".options = [ "noatime" ];

  # TODO(26.11): remove this when it becomes default
  boot.zfs.forceImportRoot = false;

  boot.extraModprobeConfig = ''
    options zfs zfs_trim_extent_bytes_min=${builtins.toString trimMinSize}
  '';

  # The stock ZFS trim timer does not support rate limiting.
  services.zfs.trim.enable = false;

  systemd.services.zroot-trim = {
    description = "Rate-limited trim of zroot";
    after = [ "zfs-import.target" ];
    wants = [ "zfs-import.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${config.boot.zfs.package}/bin/zpool trim -w -r ${builtins.toString trimRate} zroot";
      TimeoutStartSec = "infinity";
    };
  };

  systemd.timers.zroot-trim = {
    description = "Monthly trim of zroot";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "monthly";
      Persistent = true;
    };
  };

  networking.hostId = "3d3f0c83";

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;

  services.nix-serve.enable = true;
  services.nix-serve.bindAddress = ""; # needed for IPv6
  services.nix-serve.openFirewall = true;
  services.nix-serve.secretKeyFile = "/etc/nix/cache-private-key.pem";

  services.resolved.settings.Resolve.MulticastDNS = true;

  nix.nixPath = [ ("nixos-config=" + builtins.toPath ./default.nix) ];

  system.stateVersion = "23.05";
}
