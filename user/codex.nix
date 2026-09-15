{ lib, pkgs, ... }:

let
  commandRules = {
    base64 = "allow";

    cargo.add = "allow";
    cargo.bench = "allow";
    cargo.build = "allow";
    cargo.check = "allow";
    cargo.clippy = "allow";
    cargo.doc = "allow";
    cargo.fetch = "allow";
    cargo.fix = "allow";
    cargo.fuzz = "allow";
    cargo.generate-lockfile = "allow";
    cargo.info = "allow";
    cargo.insta = "allow";
    cargo.llvm-cov = "allow";
    cargo.metadata = "allow";
    cargo.miri = "allow";
    cargo.nextest = "allow";
    cargo.package = "allow";
    cargo.remove = "allow";
    cargo.rustc = "allow";
    cargo.rustdoc = "allow";
    cargo.search = "allow";
    cargo.set-version = "allow";
    cargo.test = "allow";
    cargo.tree = "allow";
    cargo.update = "allow";
    cargo.upgrade = "allow";
    cargo.vendor = "allow";

    gh.issue.list = "allow";
    gh.issue.view = "allow";
    gh.search.issues = "allow";

    home-manager.build = "allow";
    home-manager.instantiate = "allow";

    journalctl = "allow";

    nh.home.build = "allow";
    nh.os.build = "allow";

    nix.build = "allow";
    nix.eval = "allow";
    nix.flake = "allow";
    nix.fmt = "allow";
    nix.develop = "allow";
    nix.derivation.show = "allow";
    nix.path-info = "allow";
    nix.log = "allow";
    nix.search = "allow";
    nix.run = "prompt";
    nix.why-depends = "allow";

    nl = "allow";

    rustc = "allow";

    systemctl.cat = "allow";

    tmux.show-options = "allow";
  };

  renderRules =
    prefix: rules:
    lib.concatStrings (
      lib.mapAttrsToList (
        name: value:
        let
          pattern = prefix ++ [ name ];
        in
        if builtins.isAttrs value then
          renderRules pattern value
        else
          assert lib.assertMsg (builtins.elem value [
            "allow"
            "prompt"
            "forbidden"
          ]) "Invalid Codex decision for ${lib.concatStringsSep " " pattern}";
          "prefix_rule(pattern=${builtins.toJSON pattern}, decision=${builtins.toJSON value})" + "\n"
      ) rules
    );
in
{
  # TODO: use regular symlink when https://github.com/openai/codex/issues/32658 is fixed
  home.activation.codexRules = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run ${pkgs.coreutils}/bin/install -Dm644 \
      ${pkgs.writeText "codex-home-manager.rules" (renderRules [ ] commandRules)} \
      "$HOME/.codex/rules/home-manager.rules"
  '';
}
