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
    (pkgs.callPackage "${import ../../../../dep/nixpkgs-unstable/thunk.nix}/pkgs/applications/video/mpv/scripts/mpvacious.nix" {})
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
