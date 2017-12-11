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
		this.filter.toggleUserOverride(new WindowObjectClass("ahk_id " hwnd))
		this.windowManager.triggerLayout()
		return this
	}
	
	trackAllVisibleWindows()
	{
		;todo
		return this
	}
}