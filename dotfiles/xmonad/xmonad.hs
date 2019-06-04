{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Concurrent

import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns

import System.Taffybar
import System.Taffybar.Information.CPU
import System.Taffybar.SimpleConfig
import System.Taffybar.Widget hiding (windows, borderWidth)
import System.Taffybar.Widget.Generic.Graph
import System.Taffybar.Widget.Generic.PollingGraph

import qualified Data.Map as M
import qualified XMonad.StackSet as W

myWorkspaces = pure <$> ['0' .. '9']
myWorkspaceKeys = [xK_0 .. xK_9]

workspace0Keys conf@(XConfig {modMask = modm}) = M.fromList $
  [ ((m .|. modm, k), windows $ f i)
  | (i, k) <- zip myWorkspaces myWorkspaceKeys
  , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
  ]

launcherKeys conf@(XConfig {modMask = modm}) = M.fromList $
  [ ((modm, xK_a), spawn "autorandr -c")
  , ((modm, xK_s), spawn "systemctl suspend")
  , ((modm, xK_d), spawn "physlock")
  , ((modm, xK_f), spawn "emacsclient --create-frame")
  ]

main = do
  forkIO taffybar
  xmonad $ docks $ def
    { modMask = mod4Mask
    -- TODO: Put this back to smartBorders once
    -- https://github.com/xmonad/xmonad-contrib/issues/280 is fixed.
    , layoutHook = lessBorders OtherIndicated $
        layoutHook def ||| ThreeColMid 1 (3/100) (1/2)
    , borderWidth = 2
    , terminal = "termite"
    , workspaces = myWorkspaces
    , keys = workspace0Keys <+> launcherKeys <+> keys def
    }

cpuCallback = do
  (_, systemLoad, totalLoad) <- cpuLoad
  return [ totalLoad, systemLoad ]

taffybar = do
  let cpuCfg = defaultGraphConfig { graphDataColors = [ (0, 1, 0, 1), (1, 0, 1, 0.5)]
                                  , graphLabel = Just "cpu"
                                  }
      clock = textClockNew Nothing "<span fgcolor='orange'>%a %b %_d %H:%M</span>" 1
      cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
      workspaces = workspacesNew defaultWorkspacesConfig
      simpleConfig = defaultSimpleTaffyConfig
                       { startWidgets = [ workspaces ]
                       , endWidgets = [ sniTrayNew, clock, cpu ]
                       }
  startTaffybar $ toTaffyConfig simpleConfig
