class WindowCreateAndCloseWatcherClass
{
	static shellHookSetup := false
	openCallbacks := []
	closeCallbacks := []
	
	__new()
	{
		return this.__setupShellhook()
	}
	
	registerOpenCallback(callback)
	{
		this.openCallbacks.Insert(callback)
		return this
	}
	
	registerCloseCallback(callback)
	{
		this.closeCallbacks.Insert(callback)
		return this
	}

	__setupShellhook()
	{
		
		if(! this.shellHookSetup) 
		{
			this.shellHookSetup := true
			Gui +LastFound
			hWnd := WinExist()
			DllCall( "RegisterShellHookWindow", UInt,hWnd )
			MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
			OnMessage( MsgNum, func("WindowCreateAndCloseWatcherClass.newWindowCallback").bind(this))
		}
		return this
	}
	
	notifyOpenListeners(ahkWindowId)
	{
		for index, callback in this.openCallbacks
		{
			callback.call(new WindowObjectClass("ahk_id " ahkWindowId))
		}
		return this
	}
	
	;todo figure out what paramater is passed to this function and if it is useful
	notifyCloseListeners(notSureWhatThisIs)
	{
		for index, callback in this.closeCallbacks
		{
			callback.call(notSureWhatThisIs)
		}
		return this
	}
	
	newWindowCallback(wParam, lParam)
	{
		HSHELL_WINDOWDESTROYED := 2
		HSHELL_WINDOWCREATED := 1
		if (wParam == HSHELL_WINDOWCREATED)
		{
			funcObj := func("WindowCreateAndCloseWatcherClass.notifyOpenListeners").bind(this, ahkWindowId := lParam) 
			setTimer % funcObj,  -1
		} else if (wParam == HSHELL_WINDOWDESTROYED)
		{
			funcObj := func("WindowCreateAndCloseWatcherClass.notifyCloseListeners").bind(this, ahkWindowId := lParam) 
			setTimer % funcObj,  -1
		}
		return this
	}
}
