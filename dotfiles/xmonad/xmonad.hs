import XMonad
import XMonad.Config.Kde
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig
import XMonad.Util.Run

main = xmonad $ kdeConfig
         { modMask = mod4Mask 
         , layoutHook = smartBorders $ layoutHook kdeConfig
         , terminal = "termite"
         } `additionalKeys`
         [ ((mod4Mask, xK_End), safeSpawn "xscreensaver-command" ["-lock"])
         , ((mod4Mask, xK_Page_Down), safeSpawn "systemctl" ["suspend"])
         ]
