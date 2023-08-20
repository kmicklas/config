{ ... }:

{
  programs.tmux.enable = true;

  programs.tmux.historyLimit = 1000000;
  programs.tmux.mouse = true;
  programs.tmux.newSession = true;
  programs.tmux.terminal = "tmux-256color";

  programs.tmux.extraConfig = ''
    set -g default-terminal 'tmux-256color'
    set -ga terminal-overrides ',xterm-256color:RGB'

    bind Q kill-session
    bind r rename-window "#{b:pane_current_path}"
    bind R source-file ~/.config/tmux/tmux.conf
    bind s split-window
    bind v split-window -h

    bind -T root M-j select-pane -t :.+
    bind -T root M-k select-pane -t :.-
  '';
}
