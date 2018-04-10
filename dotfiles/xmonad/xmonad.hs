import XMonad
import XMonad.Layout.ThreeColumns

import qualified Data.Map as M
import qualified XMonad.StackSet as W

myWorkspaces = pure <$> ['0' .. '9']
myWorkspaceKeys = [xK_0 .. xK_9]

myKeys conf@(XConfig {modMask = modm}) = M.fromList $
  [ ((m .|. modm, k), windows $ f i)
  | (i, k) <- zip myWorkspaces myWorkspaceKeys
  , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
  ]

main = xmonad $ def
         { modMask = mod4Mask
         , layoutHook = ThreeColMid 1 (3/100) (1/2) ||| layoutHook def
         , borderWidth = 0
         , terminal = "termite"
         , workspaces = myWorkspaces
         , keys = myKeys <+> keys def
         }
