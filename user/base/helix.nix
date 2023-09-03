{ config, ... }:

let
  normal-keys = {
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
    i = "move_next_word_start";
    I = "move_next_long_word_start";
    o = "move_next_word_end";
    O = "move_next_long_word_end";
    s = "change_selection";
    u = "move_prev_word_start";
    U = "move_prev_long_word_start";
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

    keys.normal = normal-keys;
    keys.select = normal-keys;

    keys.insert = {
      f.d = "normal_mode";
    };
  };
}
