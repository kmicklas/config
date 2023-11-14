{ pkgs, ... }:

let
  source = import ../../nix/sources.nix { };

  # TODO: Remove after upgrading to nixpkgs 23.11.
  helix-23-05 = pkgs.callPackage "${import ../../dep/nixpkgs-unstable/thunk.nix}/pkgs/applications/editors/helix" {};

  helix-fork-src = pkgs.fetchFromGitHub {
    owner = "kmicklas";
    repo = "helix";
    rev = "7f07ce0c5a06be7e3d7b032c5d3eab01ed020775";
    sha256 = "sha256-9IM4ZKQ4gWH2ccVD0n7pjvdFguyzgYmv0ozygdkiYfo=";
  };

  makeAlias = name: path: pkgs.stdenv.mkDerivation {
    name = builtins.baseNameOf name;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      ln -s ${path} $out/bin/${name}
    '';
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
  # TODO: after upgrading to 23.11: programs.helix.defaultEditor = true;
  home.sessionVariables.EDITOR = "hx";

  programs.helix.package = helix-23-05.overrideAttrs {
    src = pkgs.stdenv.mkDerivation {
      name = "helix-src";

      dontUnpack = true;
      buildPhase = ''
        cp -r ${helix-fork-src} $out
        chmod +w $out/runtime/grammars
        cp -r ${helix-23-05.src}/runtime/grammars/sources $out/runtime/grammars/sources
      '';
    };
  };

  programs.helix.settings = {
    theme = "github_dark";

    editor.color-modes = true;
    editor.idle-timeout = 100;
    editor.lsp.display-messages = true;
    editor.soft-wrap.enable = true;
    editor.true-color = true;
    editor.whitespace.render = "trailing";

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
    };
    language = [
      {
        name = "python";
        language-servers = ["pyright"];
      }
    ];
    # TODO: Build these with nix.
    grammar = [
      {
        name = "rust";
        source.path = source.tree-sitter-rust;
      }
    ];
  };

  home.packages = [
    pkgs.nil
    pkgs.nodePackages.bash-language-server
    pkgs.nodePackages.dockerfile-language-server-nodejs
    pkgs.nodePackages.typescript-language-server
    pkgs.pyright

    (makeAlias "vscode-css-language-server" "${pkgs.nodePackages.vscode-css-languageserver-bin}/bin/css-languageserver")
    # TODO: This one seems broken.
    (makeAlias "vscode-html-language-server" "${pkgs.nodePackages.vscode-html-languageserver-bin}/bin/html-languageserver")
  ];
}
