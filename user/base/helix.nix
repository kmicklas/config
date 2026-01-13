{ pkgs, ... }:

let
  source = import ../../nix/sources.nix { };
  upstreamHelix = pkgs.helix;

  prettierLang = lang: parser: {
    name = lang;
    formatter = {
      command = "${pkgs.nodePackages.prettier}/bin/prettier";
      args = [ "--parser" parser ];
    };
  };

  normal-keys = type: {
    space.c = "toggle_comments";
    space.l.c = ":lsp-workspace-command";
    space.l.r = ":lsp-restart";
    space.l.s = ":lsp-stop";
    space.m.a = ":reload-all";
    space.m.c = ":config-reload";
    space.m.f = ":yank-filepath-relative";
    space.m.C-f = ":clipboard-yank-filepath-relative";
    space.m.r = ":reload";
    space.q.a = ":quit-all";
    space.q.C-a = ":quit-all!";
    space.q.b = ":buffer-close";
    space.q.C-b = ":buffer-close!";
    space.q.q = ":quit";
    space.q.C-q = ":quit!";
    space.w.d = "wclose";
    space.space = "command_palette";
    space.";" = "command_mode";

    a = "open_below";
    A = "open_above";
    C-a = "open_above";
    b = "rotate_view";
    C-b = "select_regex";
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

    backspace = "delete_char_backward";
    del = "delete_char_forward";
    ret = "insert_newline";

    # TODO: "C-," = "unindent";
    # TODO: . = jump mode
    # TODO: "C-." = "indent";
  };

in {
  programs.helix.enable = true;
  programs.helix.defaultEditor = true;

  programs.helix.package = upstreamHelix.overrideAttrs {
    src = pkgs.stdenv.mkDerivation {
      name = "helix-src";

      dontUnpack = true;
      buildPhase = ''
        cp -r ${source.helix} $out
        chmod +w $out/runtime/grammars
        cp -r ${upstreamHelix.src}/runtime/grammars/sources $out/runtime/grammars/sources
      '';

      dontCheckForBrokenSymlinks = true;
    };
  };

  programs.helix.settings = {
    theme = "github_dark";

    editor.color-modes = true;
    editor.continue-comments = false;
    editor.cursorline = true;
    editor.file-picker.hidden = false;
    editor.idle-timeout = 100;
    editor.lsp.display-inlay-hints = true;
    editor.lsp.display-messages = true;
    editor.soft-wrap.enable = true;
    editor.true-color = true;
    # editor.whitespace.render = "trailing";

    keys.normal = normal-keys "move";
    keys.select = normal-keys "extend";

    keys.insert = {
      f.d = "normal_mode";
    };
  };

  programs.helix.languages = {
    language-server = {
      pyright = {
        command = "pyright-langserver";
        args = [ "--stdio" ];
        config = {};
      };
      rust-analyzer = {
        command = "rust-analyzer";
        config = {
          inlayHints.closureReturnTypeHints.enable = "with_block";
          inlayHints.discriminantHints.enable = "fieldless";
          inlayHints.parameterHints.enable = false;
          inlayHints.typeHints.enable = false;
        };
      };
    };
    language = [
      {
        name = "python";
        language-servers = ["pyright"];
      }

      # Override bad Microsoft formatters which eat final newlines.
      # See https://github.com/djpowers/dotfiles/pull/41
      (prettierLang "css" "css")
      (prettierLang "html" "html")
      (prettierLang "javascript" "typescript")
      (prettierLang "json" "json")
      (prettierLang "tsx" "typescript")
      (prettierLang "typescript" "typescript")
    ];
  };

  home.packages = [
    pkgs.bash-language-server
    pkgs.dockerfile-language-server
    pkgs.nil
    pkgs.pyright
    pkgs.typescript-language-server
    pkgs.vscode-langservers-extracted
  ];
}
