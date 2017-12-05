class VisibleWindowsManagerClass
{
	visibleWindows := []
	
	__new(windowCreateAndCloseNotifier)
	{
		windowCreateAndCloseNotifier.registerOpenCallback(func("VisibleWindowsManagerClass.handleNewWindow").bind(this))
		windowCreateAndCloseNotifier.registerCloseCallback(func("VisibleWindowsManagerClass.handleClosedWindow").bind(this))
		return this
	}
	
	handleNewWindow(newId)
	{
		this.visibleWindows.Push(newId)
		ToolTip, % "these windows are watched " arrayToString(this.visibleWindows)
		Return	
	}

	handleClosedWindow(deadId)
	{
		deletedKeys := []
		;not sure what dead id is so lets just check if the windows we know about still exist
		for key, val in this.visibleWindows
		{
			if(! WinExist("ahk_id " val))
			{
				;i wonder if modifying the arr while iterating over it is a problem...
				deletedKeys.Insert(this.visibleWindows.delete(key))
			}
		}
		ToolTip, % "these windows are watched " arrayToString(this.visibleWindows)

		Return	
	}
}