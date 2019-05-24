{ ... }:

{
  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [
    "git"
  ];
  programs.zsh.initExtra = ''
    function prompt_status_indicator {
      local last_command_status=$?
      if test $last_command_status -gt 0
      then echo "%{$fg[red]%}($last_command_status)%{$reset_color%}"
      else echo "%{$fg[green]%}($last_command_status)%{$reset_color%}"
      fi
    }

    autoload -U colors && colors
    PROMPT='$(prompt_status_indicator) %{$fg[white]%}%~%{$reset_color%}'$'\n'"> "
  '';
}
