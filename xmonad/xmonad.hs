import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig

main = xmonad $ defaultConfig
         { modMask = mod4Mask 
         , terminal = "gnome-terminal"
         } `additionalKeys`
         [ ((mod4Mask, xK_End), safeSpawn "xlock" [])
         , ((mod4Mask, xK_Page_Down), safeSpawn "systemctl" ["suspend"])
         ]
