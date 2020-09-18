import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns

import qualified Data.Map as M
import qualified XMonad.StackSet as W

myWorkspaces = fmap pure $ ['1' .. '9'] ++ ['0']
myWorkspaceKeys = [xK_1 .. xK_9] ++ [xK_0]

workspace0Keys conf@(XConfig {modMask = modm}) = M.fromList $
  [ ((m .|. modm, k), windows $ f i)
  | (i, k) <- zip myWorkspaces myWorkspaceKeys
  , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
  ]

setScreensaverStatus :: MonadIO m => String -> String -> m ()
setScreensaverStatus status message = do
  spawn $ "systemctl --user " <> status <> " xscreensaver.service"
  spawn $ "notify-send '" <> message <> "'"

launcherKeys conf@(XConfig {modMask = modm}) = M.fromList $
  [ ((modm, xK_a), spawn "autorandr -c")
  , ((modm, xK_s), spawn "systemctl suspend")
  , ((modm, xK_d), spawn "physlock")
  , ((modm, xK_f), spawn "emacsclient --create-frame")
  , ((modm, xK_u), setScreensaverStatus "stop" "Deactivated screensaver")
  , ((modm, xK_i), setScreensaverStatus "start" "Activated screensaver")
  ]

main = xmonad $ docks $ def
  { modMask = mod4Mask
  -- TODO: Put this back to smartBorders once
  -- https://github.com/xmonad/xmonad-contrib/issues/280 is fixed.
  , layoutHook = avoidStruts $ lessBorders OtherIndicated $
      layoutHook def ||| ThreeColMid 1 (3/100) (1/2)
  , borderWidth = 5
  , terminal = "termite"
  , workspaces = myWorkspaces
  , keys = workspace0Keys <+> launcherKeys <+> keys def
  }
