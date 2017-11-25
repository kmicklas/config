import XMonad
import XMonad.Config.Kde
import XMonad.Layout.NoBorders

main = xmonad $ kdeConfig
         { modMask = mod4Mask 
         , layoutHook = smartBorders $ layoutHook kdeConfig
         , terminal = "termite"
         }
