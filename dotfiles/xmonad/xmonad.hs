import XMonad
import XMonad.Layout.ThreeColumns

main = xmonad $ def
         { modMask = mod4Mask
         , layoutHook = ThreeColMid 1 (3/100) (1/2) ||| layoutHook def
         , borderWidth = 0
         , terminal = "termite"
         }
