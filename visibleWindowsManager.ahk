class VisibleWindowsManagerClass
{
	visibleWindows := []
	
	__new(windowCreateAndCloseNotifier, layoutManager)
	{
		windowCreateAndCloseNotifier.registerOpenCallback(func("VisibleWindowsManagerClass.handleNewWindow").bind(this))
		windowCreateAndCloseNotifier.registerCloseCallback(func("VisibleWindowsManagerClass.handleClosedWindow").bind(this))
		this.layoutManager := layoutManager
		return this
	}
	
	handleNewWindow(newId)
	{
		this.visibleWindows.Push(newId)
		;~ ToolTip, % "these windows are watched " arrayToString(this.visibleWindows)
		this.triggerLayout()
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
		if(deletedKeys.maxIndex())
		{
			this.triggerLayout()
		}
		;~ ToolTip, % "these windows are watched " arrayToString(this.visibleWindows)

		Return	
	}
	
	triggerLayout()
	{
		positions := this.layoutManager.getSizeAndPositions(this.visibleWindows)
		for key, window in this.visibleWindows
		{
			p := positions[A_Index]
			WinMove, % "ahk_id " window, , % p.x, % p.y, % p.width, % p.height
		}
		return this
	}
}