{ ... }:

{
  nixpkgs.overlays = [
    (_: super: {
      # TODO: Remove this once oh-my-zsh is upgraded in nixpkgs.
      oh-my-zsh = super.oh-my-zsh.overrideAttrs (_: {
        src = import ../../../../dep/ohmyzsh/thunk.nix;
      });
    })
  ];

  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [
    "direnv"
    "dotenv"
    "git"
    "man"
  ];
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
  };
}
