import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig

main = xmonad $ defaultConfig { modMask = mod4Mask }
  `additionalKeys` [((mod4Mask, xK_End), safeSpawn "gnome-screensaver-command" ["-l"])]
