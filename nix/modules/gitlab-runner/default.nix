{ ... }:

{
  imports = [
    ../../../dep/nixos-gitlab-runner/gitlab-runner.nix
  ];

  services.gitlab-runner2.enable = true;
  services.gitlab-runner2.registrationConfigFile = "/var/lib/secrets/gitlab-runner";
}
