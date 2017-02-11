{
  isNormalUser = true;
  isSystemUser = false;
  uid = 1000;
  createHome = true;
  home = "/home/kmicklas";
  description = "Ken Micklas";
  extraGroups = [ "kmicklas" "wheel" ];
  useDefaultShell = true;
  openssh.authorizedKeys.keys = map builtins.readFile [
    ./macbook.pub
  ];
}
