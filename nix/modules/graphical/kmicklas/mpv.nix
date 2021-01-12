{ pkgs, ... }:

{
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
    (pkgs.stdenv.mkDerivation rec {
      pname = "mpvacious";
      version = "0.12";
      src = pkgs.fetchzip {
        url = "https://github.com/Ajatt-Tools/mpvacious/archive/v${version}.tar.gz";
        sha256 = "1xz4qh2ibfv03m3pfdasim9byvlm78wigx1linmih19vgg99vky2";
      };

      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/mpv/scripts
        cp subs2srs.lua $out/share/mpv/scripts
      '';
      passthru.scriptName = "subs2srs.lua";

      meta = {
        homepage = "https://github.com/Ajatt-Tools/mpvacious";
        inherit version;
      };
    })
  ];

  xdg.configFile."mpv/script-opts/subs2srs.conf".text = ''
    deck_name=inbox
    model_name=Migaku Chinese (TW)
    sentence_field=Expression
    audio_field=Audio
    image_field=Meaning
  '';
}
