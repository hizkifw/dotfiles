import Graphics.X11.ExtraTypes.XF86

import System.IO
import System.Exit

import XMonad

import XMonad.Hooks.ManageDocks

import XMonad.Layout.Fullscreen
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.TwoPane

import XMonad.Util.Run
import XMonad.Util.SpawnOnce

import qualified Data.Map as M
import qualified XMonad.StackSet as W

--
-- basic configuration
--

myModMask   = mod1Mask
myTerminal  = "kitty"
myXmobarrc  = "~/.xmonad/xmobar.hs"

--
-- startup
--

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom --experimental-backends &"

--
-- layout
--

nmaster = 1
delta = 1/10
ratio = 1/2

myLayoutHook =
  smartBorders $
  avoidStruts $
  tiled
  ||| twopane
  where
    tiled = ResizableTall nmaster delta ratio []
    twopane = TwoPane delta ratio

--
-- keybindings
--

myKeys config@(XConfig {modMask = modKey}) = M.fromList $ [
    -- launchers
    ((modKey, xK_Return), spawn (terminal config)),
    ((modKey, xK_d), spawn "dmenu_run"),

    -- close active window
    ((modKey .|. shiftMask, xK_q), kill),
    -- window focus
    ((modKey, xK_k), windows W.focusUp),
    ((modKey, xK_j), windows W.focusDown),
    ((modKey .|. shiftMask, xK_Return), windows W.swapMaster),
    -- window resizing
    ((modKey .|. shiftMask, xK_h), sendMessage Shrink),
    ((modKey .|. shiftMask, xK_l), sendMessage Expand),
    ((modKey .|. shiftMask, xK_j), sendMessage MirrorShrink),
    ((modKey .|. shiftMask, xK_k), sendMessage MirrorExpand),
    
    -- multimedia keys
    -- https://wiki.linuxquestions.org/wiki/XF86_keyboard_symbols
    ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 10 -fps 60"),
    ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 10 -fps 60"),
    ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -2%"),
    ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +2%"),

    -- restart xmonad
    ((modKey, xK_q), restart "xmonad" True),
    -- exit X
    ((modKey .|. controlMask, xK_BackSpace), io (exitWith ExitSuccess))
  ] ++
  [ -- magic code for workspace switching
    ((modKey .|. m, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces config) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
  ]

main = do
  xmproc <- spawnPipe ("xmobar " ++ myXmobarrc)

  xmonad $ fullscreenSupport $ def {
    modMask     = myModMask,
    terminal    = myTerminal,
    keys        = myKeys,
    startupHook = myStartupHook,
    layoutHook  = myLayoutHook
  }
