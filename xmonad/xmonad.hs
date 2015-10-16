import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders

main = xmonad $ defaultConfig
         { modMask = mod4Mask 
         , layoutHook = smartBorders $ layoutHook defaultConfig
         , terminal = "gnome-terminal"
         } `additionalKeys`
         [ ((mod4Mask, xK_End), safeSpawn "xlock" [])
         , ((mod4Mask, xK_Page_Down), safeSpawn "systemctl" ["suspend"])
         ]
