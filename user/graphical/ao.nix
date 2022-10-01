{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: _: {
      ao-todo = self.appimageTools.wrapType2 {
        name = "ao";
        src = self.fetchurl {
          url = "https://github.com/klaussinani/ao/releases/download/v6.9.0/ao-6.9.0-x86_64.AppImage";
          sha256 = "1h7mkxh0il038nhwzhjzy23bl629jbcsl8ay68i9xnb2q1hws8yk";
        };
      };
    })
  ];

  home.packages = [ pkgs.ao-todo ];
}
