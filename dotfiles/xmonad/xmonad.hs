import XMonad
import XMonad.Config.Kde
import XMonad.Layout.NoBorders

myManageHook = composeAll [ className  =? c --> doIgnore | c <- floatClasses ]
   where floatClasses = ["Plasma", "Plasma-desktop", "plasma", "plasma-desktop", "plasmadesktop", "plasmashell"]

main = xmonad $ kdeConfig
         { modMask = mod4Mask 
         , layoutHook = smartBorders $ layoutHook kdeConfig
         , manageHook = manageHook kdeConfig <+> myManageHook
         , terminal = "termite"
         }
