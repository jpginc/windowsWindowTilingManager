class WindowFilterClass
{
	doManageWindowUserOverride := {}
	dontManageWindowUserOverride := {}
	
	__new()
	{
		this.readSettings()
		return this
	}
	
	readSettings()
	{
		FileRead, settings, settings/donottrack.txt
		this.doNotTrack := stringToArray(settings)
		return this
	}
	
	shouldWindowBeManaged(windowObject)
	{
		if(this.dontManageWindowUserOverride[windowObject.hwnd]) 
		{
			return false
		}
		if(this.doManageWindowUserOverride[windowObject.hwnd]) 
		{
			return true
		}
		;todo
		return this.checkSettings(windowObject)
	}
	
	checkSettings(windowObj)
	{
		for key, settingsWindowObj in this.doNotTrack
		{
			if(windowObj.class == settingsWindowObj.class || windowObj.processName == settingsWindowObj.processName)
			{
				return false
			}
		}
		return true
	}
	
	toggleUserOverride(windowObject)
	{
		if(this.currentlyManagingWindow(windowObject))
		{
			this.stopManagingWindow(windowObject)
		} else
		{
			this.startManagingWindow(windowObject)
		} 
		return this		
	}
	
	currentlyManagingWindow(windowObject)
	{
		return this.doManageWindowUserOverride[windowObject.hwnd]
	}
	
	stopManagingWindow(windowObject)
	{
		this.doManageWindowUserOverride.delete(windowObject.hwnd)
		this.dontManageWindowUserOverride[windowObject.hwnd] := windowObject
		return this
	}
	
	startManagingWindow(windowObject)
	{
		this.dontManageWindowUserOverride.delete(windowObject.hwnd)
		this.doManageWindowUserOverride[windowObject.hwnd] := windowObject
		return this
	}
}