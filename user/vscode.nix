{ pkgs, ... }:

{
  programs.vscode.enable = true;
  programs.vscode.profiles.default.extensions = [
    pkgs.vscode-extensions.maximedenes.vscoq
  ];
}
