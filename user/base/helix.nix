{ ... }:

{
  programs.helix.enable = true;

  programs.helix.settings = {
    theme = "github_dark";

    keys.normal = {
      space.q.q = ":quit";
      space.space = "command_palette";

      "C-f" = "select_regex";
      "C-g" = "collapse_selection";
      "C-r" = "redo";
      "C-s" = ":write";

      a = "open_below";
      A = "open_above";
      c = "keep_primary_selection";
      e = "append_mode";
      E = "insert_at_line_end";
      f = "insert_mode";
      F = "insert_at_line_start";
      i = "move_next_word_start";
      I = "move_next_long_word_start";
      o = "move_next_word_end";
      O = "move_next_long_word_end";
      s = "change_selection";
      u = "move_prev_word_start";
      U = "move_prev_long_word_start";
      w = "undo";
      ";" = "command_mode";
      "," = "expand_selection";
      # TODO: This doesn't seem to work for some reason.
      # "." = "rotate_view";
    };

    keys.insert = {
      f.d = "normal_mode";
    };
  };
}
