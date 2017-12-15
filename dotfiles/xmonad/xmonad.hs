import XMonad
import XMonad.Layout.NoBorders

main = xmonad $ defaultConfig
         { modMask = mod4Mask 
         , layoutHook = smartBorders $ layoutHook defaultConfig
         , terminal = "termite"
         }
