import XMonad
import XMonad.Hooks.Script
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig
import XMonad.Util.Run

main = xmonad $ defaultConfig
         { modMask = mod4Mask 
         , startupHook = execScriptHook "startup"
         , layoutHook = smartBorders $ layoutHook defaultConfig
         , terminal = "gnome-terminal"
         } `additionalKeys`
         [ ((mod4Mask, xK_End), safeSpawn "xscreensaver-command" ["-lock"])
         , ((mod4Mask, xK_Page_Down), safeSpawn "systemctl" ["suspend"])
         ]
