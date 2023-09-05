{ config, ... }:

let
  normal-keys = type: {
    space.q.q = ":quit";
    space.q.a = ":quit-all";
    space.space = "command_palette";
    space.";" = "command_mode";

    "C-g" = "collapse_selection";
    "C-r" = "redo";
    "C-s" = ":write";

    a = "open_below";
    A = "open_above";
    C-a = "open_above";
    c = "keep_primary_selection";
    e = "append_mode";
    E = "insert_at_line_end";
    C-e = "insert_at_line_end";
    f = "insert_mode";
    F = "insert_at_line_start";
    C-f = "insert_at_line_start";
    i = "${type}_next_word_start";
    I = "${type}_next_long_word_start";
    o = "${type}_next_word_end";
    O = "${type}_next_long_word_end";
    s = "change_selection";
    u = "${type}_prev_word_start";
    U = "${type}_prev_long_word_start";
    w = "undo";
    "0" = "goto_line_start";
    ";" = "goto_line_end";
    "," = "expand_selection";
    # TODO: This doesn't seem to work for some reason.
    # "." = "rotate_view";
  };

in {
  programs.helix.enable = true;

  programs.helix.settings = {
    theme = "github_dark";

    keys.normal = normal-keys "move";
    keys.select = normal-keys "extend";

    keys.insert = {
      f.d = "normal_mode";
    };
  };
}
