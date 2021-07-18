{ config, pkgs, lib, ... }:

{
  imports = [
    ./reflex.nix
  ];

  environment.systemPackages = import ./packages.nix pkgs;

  time.timeZone = "America/New_York";

  nix.readOnlyStore = true;
  nix.autoOptimiseStore = true;
  nix.nixPath = let
    nixpkgs = builtins.toPath ../../../dep/nixpkgs;
  in [
    ("nixos=" + nixpkgs)
    ("nixpkgs=" + nixpkgs)
  ];
  nix.envVars = {
    NIX_GITHUB_PRIVATE_USERNAME = "kmicklas";
    NIX_GITHUB_PRIVATE_PASSWORD = builtins.replaceStrings ["\n"] [""]
      (builtins.readFile /root/github-access-token);
  };

  boot.tmpOnTmpfs = true;
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
  };

  i18n.defaultLocale = "pt_BR.UTF-8";
  console.font = "latarcyrheb-sun32";

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;
  services.openssh.forwardX11 = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;

  programs.ssh.enable = true;
  programs.ssh.extraConfig = ''
    Host kjuk
      HostName 192.168.1.231
      User kmicklas
  '';

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Theoretically will reduce hangs during nix-builds.
  services.fstrim.enable = true;

  users.users.kmicklas = import ./kmicklas;
}
