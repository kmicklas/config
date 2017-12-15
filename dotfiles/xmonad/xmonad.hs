import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns

main = xmonad $ defaultConfig
         { modMask = mod4Mask
         , layoutHook = smartBorders $
             ThreeColMid 1 (3/100) (1/2) ||| layoutHook defaultConfig
         , terminal = "termite"
         }
