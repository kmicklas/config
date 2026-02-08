{ lib, pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [
    "direnv"
    "dotenv"
    "git"
    "man"
  ];
  # Mac OS can't reliably keep this in /etc/zshrc after updates.
  programs.zsh.initContent = lib.optionalString pkgs.stdenv.isDarwin ''
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
  '' + ''
    # TODO: Should this be unconditional? It seems needed for single user install on Linux.
    if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
      . ~/.nix-profile/etc/profile.d/nix.sh
    fi

    function command_status_indicator {
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

    typeset -g command_start_time
    typeset -g command_duration

    function command_duration_preexec {
      command_start_time="$SECONDS"
    }
    function command_duration_precmd {
      if [[ -n "$command_start_time" ]]; then
        command_duration="$(($SECONDS - $command_start_time))"
      fi
      unset command_start_time
    }
    preexec_functions+=(command_duration_preexec)
    precmd_functions+=(command_duration_precmd)

    function command_duration_indicator {
      if [[ "$command_duration" -gt 0 ]]; then
        local hh="$(($command_duration / 3600))"
        local mm="$(($command_duration % 3600 / 60))"
        local ss="$(($command_duration % 60))"

        echo -n " %{$fg[yellow]%}"
        if [[ "$hh" -gt 0 ]]; then echo -n "$hh"h; fi
        if [[ "$mm" -gt 0 ]]; then echo -n "$mm"m; fi
        if [[ "$ss" -gt 0 ]]; then echo -n "$ss"s; fi
        echo "%{$reset_color%}"
      fi
    }

    autoload -U colors && colors
    PROMPT='$(command_status_indicator)$(command_duration_indicator) [%*] %{$fg_bold[blue]%}%n@%M%{$reset_color%} %~$(prompt_git_branch_indicator)$(prompt_nix_shell_indicator)'$'\n'"> "
    RPROMPT=""

    function j {
        cd "$(find -maxdepth 3 -type d -name .git | sed 's|^\./||' | sed 's|/\.git$||' | fzf --preview 'tree -L 2 {}')" || return 1
    }
  '';
  programs.zsh.shellAliases = {
    "$" = "";

    nix-zsh = "nix-shell --run zsh";
    nz = "nix-shell --run zsh";

    e = "eval $EDITOR";
    v = "eval $VISUAL";

    g = "git";

    c = "cargo";

    b = "bazel";
    bb = "bazel build";
    bba = "bazel build '...'";
    bt = "bazel test";
    bta = "bazel test '...'";
    br = "bazel run";

    gob = "go build";
    goba = "go build ./...";
    got = "go test";
    gota = "go test ./...";
    gor = "go run";

    timer = "read DURATION && bash -c \"sleep $DURATION && tmux popup echo Done $DURATION\" & disown";
  };

  programs.direnv.enable = true;
  programs.zoxide.enable = true;
}
