class UserActionManagerClass
{
	__new(windowManager, filter)
	{
		this.filter := filter
		this.windowManager := windowManager
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
	
	trackAllVisibleWindows()
	{
		;todo
		return this
	}
}