{
  isNormalUser = true;
  isSystemUser = false;
  uid = 1000;
  createHome = true;
  home = "/home/kmicklas";
  description = "Ken Micklas";
  extraGroups = [ "kmicklas" "wheel" "networkmanager" ];
  useDefaultShell = true;
  openssh.authorizedKeys.keys = map builtins.readFile [
    ./laptop.pub
    ./macbook.pub
  ];
}
