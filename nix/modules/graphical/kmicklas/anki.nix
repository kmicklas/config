{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      anki = let
        version = "2.1.22";
        dist = self.stdenv.mkDerivation {
          name = "anki-dist";
          src = self.fetchzip {
            url = "https://github.com/ankitects/anki/releases/download/${version}/anki-${version}-linux-amd64.tar.bz2";
            sha256 = "02a6jz3aj46v9vy7jbdkhj7hx8m8s6w2wpjrbz99w9bmx5px51x3";
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
        ];

        runScript = "${dist}/bin/anki";
      };
    })
  ];
}
