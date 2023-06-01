{ config, pkgs, lib, ... }:

let
  githubAccessTokenPath = /root/github-access-token;

in {
  imports = [
    ./reflex.nix
  ];

  system.stateVersion = "22.11";

  environment.systemPackages = import ./packages.nix pkgs;
  environment.enableAllTerminfo = true;

  time.timeZone = "Europe/London";

  boot.readOnlyNixStore = true;
  nix.settings.auto-optimise-store = true;

  nix.nixPath = let
    nixpkgs = builtins.toPath ../../dep/nixpkgs;
  in [
    "nixos=${nixpkgs}"
    "nixpkgs=${nixpkgs}"
  ];

  nix.envVars = lib.optionalAttrs (builtins.pathExists githubAccessTokenPath) {
    NIX_GITHUB_PRIVATE_USERNAME = "kmicklas";
    NIX_GITHUB_PRIVATE_PASSWORD = builtins.replaceStrings ["\n"] [""] (builtins.readFile githubAccessTokenPath);
  };

  nix.extraOptions = ''
    experimental-features = nix-command
  '';

  boot.tmp.useTmpfs = true;
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
  };

  i18n.defaultLocale = "pt_BR.UTF-8";
  console.font = "latarcyrheb-sun32";

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;
  services.openssh.settings.X11Forwarding = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Theoretically will reduce hangs during nix-builds.
  services.fstrim.enable = true;
}
