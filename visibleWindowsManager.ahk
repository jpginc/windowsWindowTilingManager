class VisibleWindowsManagerClass
{
	;might want to make this an object where virtual desktop id -> array of windows
	visibleWindows := []
	
	__new(windowCreateAndCloseNotifier, layoutManager, windowFilter)
	{
		windowCreateAndCloseNotifier.registerOpenCallback(func("VisibleWindowsManagerClass.handleNewWindow").bind(this))
		windowCreateAndCloseNotifier.registerCloseCallback(func("VisibleWindowsManagerClass.handleClosedWindow").bind(this))
		this.layoutManager := layoutManager
		this.windowFilter := windowFilter
		return this
	}
	
	handleMoveToAnotherDesktop()
	{
		;TODO
		return 
	}
	
	handleNewWindow(newWindowObj)
	{
		if(this.windowFilter.shouldWindowBeManaged(newWindowObj))
		{
			this.visibleWindows.Push(newWindowObj)
			;~ ToolTip, % "these windows are watched " arrayToString(this.visibleWindows)
			this.triggerLayout()
		}
		return this
	}
	
	_removeWindowsThatClosed()
	{
		deletedKeys := []
		;not sure what dead id is so lets just check if the windows we know about still exist
		for key, windowObj in this.visibleWindows
		{
			if(! windowObj.stillExists())
			{
				;i wonder if modifying the arr while iterating over it is a problem...
				deletedKeys.Insert(this.visibleWindows.delete(key))
			}
		}
		return deletedKeys
	}

	handleClosedWindow(deadId)
	{
		closedWindows := this._removeWindowsThatClosed()
	
		if(closedWindows.maxIndex())
		{
			this.triggerLayout()
		}

		return this	
	}
	
	triggerLayout()
	{
		positions := this.layoutManager.getSizeAndPositions(this.visibleWindows)
		for key, windowObj in this.visibleWindows
		{
			p := positions[A_Index]
			windowObj.move(p.x, p.y, p.width, p.height)
		}
		return this
	}
}