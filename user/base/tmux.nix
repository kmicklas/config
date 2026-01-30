{ ... }:

{
  programs.tmux.enable = true;

  programs.tmux.sensibleOnTop = false;
  programs.tmux.aggressiveResize = true;
  programs.tmux.baseIndex = 1;
  programs.tmux.clock24 = true;
  programs.tmux.escapeTime = 120;
  programs.tmux.historyLimit = 1000000;
  programs.tmux.mouse = true;
  programs.tmux.prefix = "C-Space";
  programs.tmux.terminal = "tmux-256color";

  programs.tmux.extraConfig = ''
    set -g allow-passthrough on # Allow Emacs clipetty to work
    set -g focus-events on
    set -g renumber-windows on
    set -ga terminal-overrides ",xterm-256color:RGB"

    set -g status-style "bg=#333333 fg=#bbbbbb dim"
    set -g status-left ""
    set -g status-right "#W #[fg=#cccccc,bg=#444444] %H:%M #[fg=#bbbbbb,bg=#333333] %d/%m "

    setw -g window-status-separator ""
    setw -g window-status-format "#[fg=#333333,bg=#99bbdd] #I #[fg=#cccccc,bg=#444444] #{b:pane_current_path} "
    setw -g window-status-current-format "#[fg=#333333,bg=#ddbb99] #I #[fg=#cccccc,bg=#444444] #{b:pane_current_path} "

    bind g new-window -c "#{pane_current_path}" $SHELL -c "jjui || lazygit"
    bind j new-window $SHELL -i -c "j; exec $SHELL"
    bind Q kill-session
    bind r rename-window "#{b:pane_current_path}"
    bind R source-file ~/.config/tmux/tmux.conf
    bind s split-window -c "#{pane_current_path}"
    bind v split-window -h -p 30 -c "#{pane_current_path}"

    bind -T root M-j select-pane -t :.+
    bind -T root M-k select-pane -t :.-
  '';
}
