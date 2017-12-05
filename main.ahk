#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent

notifier := new WindowCreateAndCloseWatcherClass()
notifier.registerOpenCallback(func("handleNewWindow"))
notifier.registerCloseCallback(func("handleClosedWindow"))
return

handleNewWindow(newId)
{
	WinGetTitle, Title, ahk_id %NewID%
	WinGetClass, Class, ahk_id %NewID%
	newHwnd := WinExist("ahk_id " NewID)
	ToolTip, New Window Opened Title:`t%Title%`nClass:`t%Class%`n%newHwnd%
	Return	
}

handleClosedWindow(deadId)
{
	ToolTip, New Window CLOSED!! %deadId%
	Return	
}

#d::ExitApp

#include newWindowNotifier.ahk