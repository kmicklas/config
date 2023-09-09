{ ... }:

{
  programs.tmux.enable = true;

  programs.tmux.historyLimit = 1000000;
  programs.tmux.mouse = true;
  programs.tmux.terminal = "tmux-256color";

  programs.tmux.extraConfig = ''
    set -g allow-passthrough on # Allow Emacs clipetty to work
    set -g default-terminal "tmux-256color"
    set -ga terminal-overrides ",xterm-256color:RGB"

    set -g renumber-windows on
    set -g base-index 1
    setw -g pane-base-index 1

    set -g status-style "bg=#333333 fg=#bbbbbb dim"
    set -g status-left ""
    set -g status-right "#W #[fg=#cccccc,bg=#444444] %d/%m #[fg=#bbbbbb,bg=#333333] %H:%M "

    setw -g window-status-separator ""
    setw -g window-status-format "#[fg=#333333,bg=#99bbdd] #I #[fg=#cccccc,bg=#444444] #{b:pane_current_path} "
    setw -g window-status-current-format "#[fg=#333333,bg=#ddbb99] #I #[fg=#cccccc,bg=#444444] #{b:pane_current_path} "

    unbind-key C-b
    set-option -g prefix C-Space
    bind-key C-Space send-prefix

    bind g new-window -c "#{pane_current_path}" lazygit
    bind Q kill-session
    bind r rename-window "#{b:pane_current_path}"
    bind R source-file ~/.config/tmux/tmux.conf
    bind s split-window -c "#{pane_current_path}"
    bind v split-window -h -c "#{pane_current_path}"

    bind -T root M-j select-pane -t :.+
    bind -T root M-k select-pane -t :.-
  '';
}
