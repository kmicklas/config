{ config, ... }:

{
  programs.zed-editor.enable = true;

  xdg.configFile."zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink (
    builtins.toPath ./settings.json
  );
  xdg.configFile."zed/keymap.json".source = config.lib.file.mkOutOfStoreSymlink (
    builtins.toPath ./keymap.json
  );
}
