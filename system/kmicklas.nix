{ ... }:

let homedir = "/home/kmicklas";
in {
  users.users.kmicklas = {
    isNormalUser = true;
    isSystemUser = false;
    uid = 1000;
    createHome = true;
    home = homedir;
    shell = homedir + "/.nix-profile/bin/zsh";
    description = "Ken Micklas";
    extraGroups = [
      "kmicklas"
      "wheel"
      "networkmanager"
      "systemd-journal"
      "kvm"
      "libvirtd"
    ];
    useDefaultShell = true;
    openssh.authorizedKeys.keys = map builtins.readFile [
      ../hosts/pej/kmicklas/id_rsa.pub
    ];
  };
}
