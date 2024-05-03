{ lib, pkgs, ... }:

let
  source = import ../../nix/sources.nix { };
  nixpkgs-unstable = import source.nixpkgs-unstable { };

in {
  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [
    "direnv"
    "dotenv"
    "git"
    "man"
  ];
  # Mac OS can't reliably keep this in /etc/zshrc after updates.
  programs.zsh.initExtraFirst = lib.optionalString pkgs.stdenv.isDarwin ''
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
  '' + ''
    # TODO: Should this be unconditional? It seems needed for single user install on Linux.
    if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
      . ~/.nix-profile/etc/profile.d/nix.sh
    fi
  '';
  programs.zsh.initExtra = ''
    function prompt_status_indicator {
      local last_command_status=$?
      if test $last_command_status -gt 0
      then echo "%{$fg_bold[red]%}($last_command_status)%{$reset_color%}"
      else echo "%{$fg_bold[green]%}($last_command_status)%{$reset_color%}"
      fi
    }
    function prompt_nix_shell_indicator {
      if [[ -v IN_NIX_SHELL ]]
      then echo " %{$fg_bold[red]%}<NIX>%{$reset_color%}"
      fi
    }
    function prompt_git_branch_indicator {
      local branch=$(git_current_branch)
      if [[ ! -z $branch ]]
      then echo " ($branch)"
      fi
    }

    autoload -U colors && colors
    PROMPT='$(prompt_status_indicator) [%*] %{$fg_bold[blue]%}%n@%M%{$reset_color%} %~$(prompt_git_branch_indicator)$(prompt_nix_shell_indicator)'$'\n'"> "
    RPROMPT=""

    function j {
        cd "$(find -maxdepth 3 -type d -name .git | sed 's|^\./||' | sed 's|/\.git$||' | fzf --preview 'tree -L 2 {}')" || return 1
    }
  '';
  programs.zsh.shellAliases = {
    nix-zsh = "nix-shell --run zsh";
    nz = "nix-shell --run zsh";
    e = "eval $EDITOR";
    v = "eval $VISUAL";
    b = "bazel";
    bb = "bazel build";
    bba = "bazel build '...'";
    bt = "bazel test";
    bta = "bazel test '...'";
    br = "bazel run";
    c = "cargo";
    g = "git";
    lg = "lazygit";
  };

  programs.atuin.enable = true;
  programs.atuin.settings = {
    show_help = false;
    style = "compact";
    update_check = false;
  };
  # TODO: Remove once upgrading to 24.05.
  programs.atuin.package = nixpkgs-unstable.atuin.overrideAttrs (self: {
    # TODO: Remove once https://github.com/openzfs/zfs/issues/14290 is fixed.
    patches = self.patches ++ [ ./atuin-zfs.patch ];
  });

  programs.direnv.enable = true;
  programs.zoxide.enable = true;
}
