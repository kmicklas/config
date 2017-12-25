{
  isNormalUser = true;
  isSystemUser = false;
  uid = 1000;
  createHome = true;
  home = "/home/kmicklas";
  description = "Ken Micklas";
  extraGroups = [ "kmicklas" "wheel" "networkmanager" "docker" ];
  useDefaultShell = true;
  openssh.authorizedKeys.keys = map builtins.readFile [
    ./macbook.pub
    ./work-laptop.pub
  ];
}
