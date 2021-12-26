{ pkgs, ... }:

{
  xdg.configFile."river/init" = {
    executable = true;
    text = let
      riverctl = "${pkgs.river}/bin/riverctl";
      rivertile = "${pkgs.river}/bin/rivertile";

      alacritty = "${pkgs.alacritty}/bin/alacritty";
      light = "${pkgs.light}/bin/light";
      pamixer = "${pkgs.pamixer}/bin/pamixer";
      playerctl = "${pkgs.playerctl}/bin/playerctl";
    in ''
      #!/bin/sh
      # mod="Mod4"
      mod="Mod1"

      ${riverctl} map normal $mod+Shift C close
      ${riverctl} map normal $mod+Shift Q exit

      ${riverctl} map normal $mod J focus-view next
      ${riverctl} map normal $mod K focus-view previous

      ${riverctl} map normal $mod+Shift J swap next
      ${riverctl} map normal $mod+Shift K swap previous

      ${riverctl} map normal $mod E focus-output next
      ${riverctl} map normal $mod W focus-output previous

      ${riverctl} map normal $mod+Shift E send-to-output next
      ${riverctl} map normal $mod+Shift W send-to-output previous

      ${riverctl} map normal $mod Return zoom

      ${riverctl} map normal $mod H send-layout-cmd rivertile "main-ratio -0.05"
      ${riverctl} map normal $mod L send-layout-cmd rivertile "main-ratio +0.05"

      ${riverctl} map-pointer normal $mod BTN_LEFT move-view
      ${riverctl} map-pointer normal $mod BTN_RIGHT resize-view

      for i in $(seq 0 9); do
        tags=$((1 << $i))
        ${riverctl} map normal $mod $i set-focused-tags $tags
        ${riverctl} map normal $mod+Shift $i set-view-tags $tags
      done

      ${riverctl} map normal $mod T toggle-float

      ${riverctl} map normal $mod+Shift F toggle-fullscreen

      ${riverctl} map normal $mod Up    send-layout-cmd rivertile "main-location top"
      ${riverctl} map normal $mod Right send-layout-cmd rivertile "main-location right"
      ${riverctl} map normal $mod Down  send-layout-cmd rivertile "main-location bottom"
      ${riverctl} map normal $mod Left  send-layout-cmd rivertile "main-location left"

      ${riverctl} map normal $mod+Shift Return spawn ${pkgs.alacritty}/bin/alacritty

      for mode in normal locked
      do
          ${riverctl} map $mode None XF86AudioRaiseVolume  spawn '${pamixer} -i 5'
          ${riverctl} map $mode None XF86AudioLowerVolume  spawn '${pamixer} -d 5'
          ${riverctl} map $mode None XF86AudioMute         spawn '${pamixer} --toggle-mute'

          ${riverctl} map $mode None XF86AudioMedia spawn '${playerctl} play-pause'
          ${riverctl} map $mode None XF86AudioPlay  spawn '${playerctl} play-pause'
          ${riverctl} map $mode None XF86AudioPrev  spawn '${playerctl} previous'
          ${riverctl} map $mode None XF86AudioNext  spawn '${playerctl} next'

          ${riverctl} map $mode None XF86MonBrightnessUp   spawn '${light} -A 5'
          ${riverctl} map $mode None XF86MonBrightnessDown spawn '${light} -U 5'
      done

      ${riverctl} background-color 0x002b36
      ${riverctl} border-color-focused 0x93a1a1
      ${riverctl} border-color-unfocused 0x586e75

      ${riverctl} set-repeat 50 300

      ${riverctl} default-layout rivertile
      exec ${rivertile} -view-padding 6 -outer-padding 6
    '';
  };
}
