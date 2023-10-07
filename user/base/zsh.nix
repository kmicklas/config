{ lib, pkgs, ... }:

{
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

  home.packages = with pkgs; [
    direnv
  ];
}
