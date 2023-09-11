{ config, ... }:

let
  normal-keys = type: {
    space.c = "toggle_comments";
    space.q.q = ":quit";
    space.q.a = ":quit-all";
    space.space = "command_palette";
    space.";" = "command_mode";

    a = "open_below";
    A = "open_above";
    C-a = "open_above";
    b = "rotate_view";
    # TODO: C-b
    c = "keep_primary_selection";
    C-c = "copy_selection_on_next_line";
    e = "append_mode";
    E = "insert_at_line_end";
    C-e = "insert_at_line_end";
    f = "insert_mode";
    F = "insert_at_line_start";
    C-f = "insert_at_line_start";
    C-g = "goto_file_end";
    i = "${type}_next_word_start";
    I = "${type}_next_long_word_start";
    C-k = "kill_to_line_end";
    o = "${type}_next_word_end";
    O = "${type}_next_long_word_end";
    C-p = "paste_before";
    C-r = "replace_selections_with_clipboard";
    s = "change_selection";
    C-s = ":write";
    C-t = "till_prev_char";
    u = "${type}_prev_word_start";
    U = "${type}_prev_long_word_start";
    # TODO: C-u
    w = "undo";
    C-w = "redo";
    C-x = "extend_to_line_bounds";
    # TODO: C-y
    "0" = "goto_line_start";
    "," = "expand_selection";
    # TODO: "C-," = "unindent";
    # TODO: . = jump mode
    # TODO: "C-." = "indent";
  };

in {
  programs.helix.enable = true;

  programs.helix.settings = {
    theme = "github_dark";

    editor.true-color = true;
    editor.color-modes = true;

    keys.normal = normal-keys "move";
    keys.select = normal-keys "extend";

    keys.insert = {
      f.d = "normal_mode";
    };
  };

  programs.helix.languages = {
    language = [
      {
        name = "python";
        language-server = {
          command = "pyright-langserver";
          args = [ "--stdio" ];
        };
        config = {};
      }
    ];
  };
}
