#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
if(! A_IsAdmin)
{
    ;dll calls window movers will not work without admin
    Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
    ExitApp
}



notifier := new WindowCreateAndCloseWatcherClass()
filter := new WindowFilterClass()
layout := new DefaultLayoutManagerClass()
manager := new VisibleWindowsManagerClass(notifier, layout, filter)
userActionManager := new UserActionManagerClass(manager, filter)

manager.trackAllWindows()

return

#t::
{
    userActionManager.toggleManageActiveWindow()
    return
}
#g::
{
    manager.trackAllWindows()
    return
}


#d::ExitApp

#include newWindowNotifier.ahk
#include visibleWindowsManager.ahk
#include common.ahk
#include layoutManager.ahk
#include positionObject.ahk
#include windowObject.ahk
#include windowFilter.ahk
#include userActionManager.ahk