class UserActionManagerClass
{
	__new(windowManager, filter, layoutManager)
	{
		this.filter := filter
		this.windowManager := windowManager
		this.layoutManager := layoutManager
		return this
	}
	
	toggleManageActiveWindow()
	{
		hwnd := WinExist("A")
		windowObj := new WindowObjectClass("ahk_id " hwnd)
		if(this.windowManager.isTracking(windowObj)) {
			this.filter.stopManagingWindow(windowObj)
			this.windowManager.stopTracking(windowObj)
		} else {
			this.filter.startManagingWindow(windowObj)
			this.windowManager.handleNewWindow(windowObj)
		}
		return this
	}
	
	moveSplitLeft()
	{
		this.layoutManager.leftOffset += 100
		this.windowManager.triggerLayout()
		return this
	}
	
	moveSplitRight()
	{
		this.layoutManager.leftOffset -= 100
		this.windowManager.triggerLayout()
		return this
	}
	
	trackAllVisibleWindows()
	{
		;todo
		return this
	}
}