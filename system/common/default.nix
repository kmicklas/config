{ pkgs, lib, ... }:

let
  githubAccessTokenPath = /root/github-access-token;

in {
  imports = [
    ./reflex.nix
  ];

  system.stateVersion = "23.05";

  environment.systemPackages = import ./packages.nix pkgs;
  environment.enableAllTerminfo = true;

  time.timeZone = lib.mkDefault "Europe/London";

  nix.settings.auto-optimise-store = true;
  nix.settings.download-buffer-size = 1024 * 1024 * 1024;

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Support prebuilt Linux binaries.
  programs.nix-ld.enable = true;
  services.envfs.enable = true;

  boot.tmp.useTmpfs = true;
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
  };

  i18n.defaultLocale = "pt_BR.UTF-8";
  console.font = "latarcyrheb-sun32";

  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;

  services.openssh.enable = true;
  services.openssh.settings.X11Forwarding = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  virtualisation.containers.enable = true;

  services.fstrim.enable = true;
  # Regular fstrim doesn't work for ZFS.
  services.zfs.trim.enable = true;

  # Need to run this manually:
  # sudo zfs set com.sun:auto-snapshot=true zroot/nixos/home
  # TODO: Can this be set declaratively?
  services.zfs.autoSnapshot.enable = true;
}
