#SingleInstance Force

; Notify
TrayTip, komorebi.ahk, Starting komorebi, , 1

; Reload script
^#!r::Reload

; Use generated configuration
#Include %A_ScriptDir%\komorebic.lib.ahk
#Include %A_ScriptDir%\komorebi.generated.ahk

; Start komorebi
RunWait, komorebic.exe start --await-configuration, , Hide

; Default to minimizing windows when switching workspaces
WindowHidingBehaviour("minimize")

; Enable focus follows mouse
ToggleFocusFollowsMouse("windows")

; Set cross-monitor move behaviour to insert instead of swap
CrossMonitorMoveBehaviour("insert")

; Enable hot reloading of changes to this file
WatchConfiguration("enable")

; Ensure there are 10 workspaces created on monitor 0, and 1 on monitor 1
EnsureWorkspaces(0, 10)
EnsureWorkspaces(1, 1)

; Configure the invisible border dimensions
InvisibleBorders(7, 0, 14, 7)
ActiveWindowBorder("disable")
Loop, 10 {
    ContainerPadding(0, A_Index - 1, 0)
    WorkspacePadding(0, A_Index - 1, 0)
}

; Allow komorebi to start managing windows
CompleteConfiguration()

; Notify
TrayTip, komorebi.ahk, komorebi Started, , 1

; Change the focused window, Alt + Vim direction keys (HJKL)
!h::
    Focus("left")
return

!j::
    Focus("down")
return

!k::
    Focus("up")
return

!l::
    Focus("right")
return

; Move the focused window in a given direction, Alt + Shift + Vim direction keys (HJKL)
!+h::
    Move("left")
return

!+j::
    Move("down")
return

!+k::
    Move("up")
return

!+l::
    Move("right")
return

; Workspace layouts
!v::
    ChangeLayout("vertical-stack")
return

!e::
    ChangeLayout("horizontal-stack")
return

; Switch between different workspaces
!1::
!2::
!3::
!4::
!5::
!6::
!7::
!8::
!9::
    WorkspaceNum := SubStr(A_ThisHotkey, 2) - 1
    FocusMonitorWorkspace(0, WorkspaceNum)
return
!0::
    ; Special case: 0 is secondary monitor
    FocusMonitorWorkspace(1, 0)
return

; Move windows between different workspaces
!+1::
!+2::
!+3::
!+4::
!+5::
!+6::
!+7::
!+8::
!+9::
    WorkspaceNum := SubStr(A_ThisHotkey, 3) - 1
    MoveToMonitor(0)
    MoveToWorkspace(WorkspaceNum)
return
!+0::
    ; Special case: 0 is secondary monitor
    MoveToMonitor(1)
    MoveToWorkspace(0)
return
