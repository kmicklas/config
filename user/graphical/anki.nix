{ pkgs, ... }:

let
  source = import ../../nix/sources.nix { };

in {
  nixpkgs.overlays = [
    (self: super: {
      anki = let
        version = "2.1.35";
        src = source.anki;
      in (import source."nixpkgs-21.11" {}).buildFHSUserEnv {
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

        runScript = "anki-wrapped";

        extraInstallCommands = ''
          mkdir -p $out/share/applications
          mkdir -p $out/share/pixmaps
          cp ${src}/anki.desktop $out/share/applications
          cp ${src}/anki.png ${src}/anki.xpm $out/share/pixmaps

          cat << EOF > $out/bin/anki-wrapped
          #!/bin/sh
          QT_XCB_GL_INTEGRATION=none exec ${src}/bin/anki $@
          EOF

          chmod +x $out/bin/anki-wrapped

          substituteInPlace $out/share/applications/anki.desktop --replace Exec=anki Exec=$out/bin/anki-wrapped
        '';
      };
    })
  ];
}
