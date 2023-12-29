{ lib, pkgs, ... }:

let
  source = import ../../nix/sources.nix { };

in {
  programs.mpv.enable = true;
  programs.mpv.config = {
    sub-visibility = "yes";
    sub-auto = "fuzzy";
    audio-file-auto = "fuzzy";
    save-position-on-quit = "yes";
    autofit-larger = "100%x100%";
    geometry = "50%:50%";
    sub-font-size = "50";
  };
  programs.mpv.scripts = [
    pkgs.mpvScripts.mpvacious
  ] ++ lib.flip map ["sub-pause" "sub-skip"] (script:
    pkgs.stdenv.mkDerivation rec {
      pname = script;
      version = "2020-11-27";
      src = source.mpv-sub-scripts;

      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/mpv/scripts
        cp ${script}.lua $out/share/mpv/scripts
      '';
      passthru.scriptName = "${script}.lua";

      meta = {
        homepage = "https://github.com/Ben-Kerman/mpv-sub-scripts";
        inherit version;
      };
    }
  );

  xdg.configFile."mpv/script-opts/subs2srs.conf".text = ''
    deck_name=inbox::subs
    model_name=Chinese (simplified)
    sentence_field=Expression
    audio_field=Audio
    image_field=Snapshot
    nuke_spaces=no
  '';

  home.packages = with pkgs; [
    ffmpeg
    ffmpeg-normalize
  ];
}
