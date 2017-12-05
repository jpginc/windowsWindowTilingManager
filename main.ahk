#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent

notifier := new WindowCreateAndCloseWatcherClass()
manager := new VisibleWindowsManagerClass(notifier, new DefaultLayoutManagerClass())
return



#d::ExitApp

#include newWindowNotifier.ahk
#include visibleWindowsManager.ahk
#include common.ahk
#include layoutManager.ahk
#include positionObject.ahk