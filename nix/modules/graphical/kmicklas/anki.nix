{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      anki = let
        version = "2.1.35";
        dist = self.stdenv.mkDerivation {
          name = "anki-dist";
          src = self.fetchzip {
            url = "https://github.com/ankitects/anki/releases/download/${version}/anki-${version}-linux-amd64.tar.bz2";
            sha256 = "0kzblbb0hzy7hp8141rjyg68020d6kgbjdzsm632ng5y5g5i2f29";
          };
          buildCommand = "cp -r $src $out";
        };
      in self.buildFHSUserEnv {
        name = super.anki.pname;
        inherit (super.anki) meta;

        passthru = {
          inherit (super.anki) man;
          inherit version;
        };

        targetPkgs = pkgs: with pkgs; [
          expat
          fontconfig
          freetype
          glib
          libGL
          libxkbcommon
          mpv
          nspr
          nss
          systemd
          zlib

          xorg.libX11
          xorg.libXcomposite
          xorg.libXcursor
          xorg.libXdamage
          xorg.libXfixes
          xorg.libXi
          xorg.libXrandr
          xorg.libXrender
          xorg.libxcb
          xorg.xcbutilimage
          xorg.xcbutilkeysyms
          xorg.xcbutilrenderutil
          xorg.xcbutilwm
        ];

        runScript = "${dist}/bin/anki";
      };
    })
  ];
}
