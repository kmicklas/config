import XMonad
import XMonad.Layout.ThreeColumns

main = xmonad $ defaultConfig
         { modMask = mod4Mask
         , layoutHook = ThreeColMid 1 (3/100) (1/2) ||| layoutHook defaultConfig
         , borderWidth = 0
         , terminal = "termite"
         }
