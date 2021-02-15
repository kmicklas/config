{ lib, pkgs, ... }:

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
  ] ++ lib.flip map ["sub-pause" "sub-skip"] (script:
    pkgs.stdenv.mkDerivation rec {
      pname = script;
      version = "2020-11-27";
      src = pkgs.fetchFromGitHub {
        owner = "Ben-Kerman";
        repo = "mpv-sub-scripts";
        rev = "b2b2b0cba40306d17f7b1b9e443b99961fbce39e";
        sha256 = "1wx56anw4yg8krc20hps0gbmgs4x3j4nj64gkhm0d6l53wfqy02b";
      };

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
    model_name=Migaku Chinese (TW)
    sentence_field=Expression
    audio_field=Audio
    image_field=Meaning
    nuke_spaces=no
  '';
}
